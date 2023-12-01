import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'globals.dart';
import 'home.dart';

class MyType extends StatefulWidget {
  const MyType({super.key, required String title});
  @override
  State<MyType> createState() => _typeState();
}

class _typeState extends State<MyType> {
  int adpValue = 0;

  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();

  // Define a list to store selected images
  List<File> _selectedImages = [];

  void _pickImages() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _selectedImages = result.paths.map((path) => File(path!)).toList();
      });
    }
  }

  Future<void> _uploadImagesToFirestore(String petId) async {
    final storage = FirebaseStorage.instance;
    for (int i = 0; i < _selectedImages.length; i++) {
      final Reference imageReference =
      storage.ref().child('petImages/$petId/${nameController.text}_$i.jpg');
      final UploadTask uploadTask = imageReference.putFile(_selectedImages[i]);

      // Wait for the image to be uploaded and get its download URL
      await uploadTask.whenComplete(() async {
        final imagesUrl = await imageReference.getDownloadURL();

        // Store the image URL in Firestore
        globalImagesUrl=imagesUrl;
      });
    }
  }

  void _storeSelectedOptions() {
    String selectedType = adpValue == 7 ? 'Permanent' : 'Temporary';

    // Store the selected values in Firestore
    FirebaseFirestore.instance.collection('SelectedOptions').add({
      'adpValue': selectedType,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Pet"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Text('Adoption Type'),
            SizedBox(height: 5),
            Row(
              children: [
                Radio(
                  value: 1,
                  groupValue: adpValue,
                  onChanged: (value) {
                    setState(() {
                      adpValue = (value as int?)!;
                      adptypeController.text='Permanent';
                    });
                  },
                ),
                SizedBox(width: 10.0),
                Text('Permanent'),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: 2,
                  groupValue: adpValue,
                  onChanged: (value) {
                    setState(() {
                      adpValue = (value as int?)!;
                      adptypeController.text='Temporary';
                    });
                  },
                ),
                SizedBox(width: 10.0),
                Text('Temporary'),
              ],
            ),
            SizedBox(height: 10),
            if (adpValue == 2)
              Column(
                children: [
                  Text('Dates:'),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                         context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2023),
                        lastDate: DateTime(2050),
                      );

                      if (pickedDate != null &&
                          pickedDate != fromDateController.text) {
                        setState(() {
                          fromDateController.text =
                          pickedDate.toLocal().toString().split(' ')[0];
                        });
                      }
                    },
                    child: Text('From'),
                  ),
                  if (fromDateController.text.isNotEmpty)
                    Text('From: ${fromDateController.text}'),

                  SizedBox(height: 10),

                  ElevatedButton(
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2023),
                        lastDate: DateTime(2050),
                      );

                      if (pickedDate != null &&
                          pickedDate != toDateController.text) {
                        if (pickedDate.isBefore(
                            DateTime.parse(fromDateController.text))) {
                          Fluttertoast.showToast(
                            msg:
                            "Error: From date should be greater than to date",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            textColor: Colors.redAccent,
                          );
                        } else {
                          setState(() {
                            toDateController.text =
                            pickedDate.toLocal().toString().split(' ')[0];
                          });
                        }
                      }
                    },
                    child: Text('To'),
                  ),
                  if (toDateController.text.isNotEmpty)
                    Text('To: ${toDateController.text}'),

                  SizedBox(height: 10),
                ],
              ),

            Text('Special requirements in adopter'),
            SizedBox(height: 5),
            TextField(
              controller: TextEditingController(),
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                fillColor: Colors.blue.shade100,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 10),
            Column(
              children: [
                ElevatedButton(
                  onPressed: _pickImages,
                  child: Text('Select Images'),
                ),
                SizedBox(height: 16.0),
                _selectedImages.isNotEmpty
                    ? Column(
                  children: _selectedImages
                      .map((image) => Image.file(image))
                      .toList(),
                )
                    : Text('No images selected.'),
              ],
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                Map<String, dynamic> originalMap = {
                  'owner': ownerController.text,
                  'phone': phoneController.text,
                  'email': emailController.text,
                  'address': addressController.text,

                  "petreg": regnumbetController.text,
                  'name': nameController.text,
                  'type': typeController.text,
                  'breed': breedController.text,
                  'weight': weightController.text,
                  'gender': genderController.text,
                  'age': petageController.text,

                  //   'vaccine':vaccineController.text,
                  'vaccine1': vaccineCompletedcontroller.text,
                  'dueVaccine': dueVaccineController.text,
                  //  'health':healthController.text,
                  //type

                  'adpType': adptypeController.text,
                  'fromdate': fromDateController.text,
                  'todate': toDateController.text,
                  //---image pic
                  "imageUrl":globalImageUrl  ,
                  "imagesUrl":globalImagesUrl  ,
                  'brekfast_time': breakfastController.text,
                  'lunchtime': LunchtimeController.text,
                  'dinnertime': dinnerController.text,
                  //  'walk':walkController.text,
                  'w_duration': wDurationController.text,
                  'favfood': favFoodController.text,
                  'tipsfood': tipsFoodController.text,
                  // 'diet':dietController.text,
                  //'exercise':exerciseController.text,

                  //  'other':otherController.text,

                  'health1': healthController1.text,
                };

                DocumentReference petRef =
                  await FirebaseFirestore.instance.collection('Pets').add(
                  originalMap,
                );

                String petId = petRef.id;

                await _uploadImagesToFirestore(petId);

                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Thank You"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Thank you for Adding pet!"),
                          SizedBox(height: 10),
                          Image.asset(
                              'assets/images/thank-you.png'), // Display the thank-you GIF from assets
                        ],
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                            adptypeController.clear();
                            fromDateController.clear();
                            toDateController.clear();
                            // ... (clear other form fields)
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => HomePage()),
                            );
                          },
                          child: Text("OK"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
