import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'home.dart';

class adopter extends StatefulWidget {
  @override
  _adopterState createState() => _adopterState();
}

class _adopterState extends State<adopter> {
  TextEditingController adptnameController = TextEditingController();
  TextEditingController adptageController = TextEditingController();
  TextEditingController adptaddressController = TextEditingController();
  TextEditingController adptemailController = TextEditingController();
  TextEditingController adptphoneController = TextEditingController();
  TextEditingController adptexperienceController = TextEditingController();
  TextEditingController adpthouseController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  String selectedIdType = "Select Goverment Id";
  List<String> idTypes = ["Voter ID", "Aadhar Card", "Pan Card"];

  File? _image;


  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      }
    });
  }

  Future<void> _uploadImage() async {
    if (_image != null) {
      Reference storageReference =
      FirebaseStorage.instance.ref().child('profile_pics/${DateTime.now()}.jpg');
      UploadTask uploadTask = storageReference.putFile(_image!);
      await uploadTask.whenComplete(() {
        print('Image uploaded to storage');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_image != null)
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: FileImage(_image!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Select Profile Photo'),
            ),
            SizedBox(
              height: 10,
            ),
            Text('Name'),
            SizedBox(height: 5),
            TextField(
              controller: adptnameController,
              style: TextStyle(color: Colors.black),
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                fillColor: Colors.blue.shade100,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text('Age'),
            SizedBox(
              height: 5,
            ),
            TextField(
              controller: adptageController,
              style: TextStyle(color: Colors.black),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  fillColor: Colors.blue.shade100,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            Text('Address'),
            SizedBox(
              height: 5,
            ),
            TextField(
              controller: adptaddressController,
              style: TextStyle(color: Colors.black),
              keyboardType: TextInputType.streetAddress,
              decoration: InputDecoration(
                  fillColor: Colors.blue.shade100,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
            SizedBox(
              height: 10,
            ),

            SizedBox(
              height: 10,
            ),
            Text('Phone No. '),
            SizedBox(
              height: 5,
            ),
            TextField(
              controller: adptphoneController,
              style: TextStyle(color: Colors.black),
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  fillColor: Colors.blue.shade100,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            Text('Type of housing you reside'),
            SizedBox(
              height: 5,
            ),
            TextField(
              controller: adpthouseController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  fillColor: Colors.blue.shade100,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            Text('Experience about pet '),
            SizedBox(
              height: 5,
            ),
            TextField(
              controller: adptexperienceController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  fillColor: Colors.blue.shade100,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            Text('Why do you want to adopt pet?'),
            SizedBox(
              height: 5,
            ),
            TextField(
              controller: reasonController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  fillColor: Colors.blue.shade100,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
            SizedBox(height: 16.0),// ... Other text fields and UI components
            ElevatedButton(
              onPressed: () async {
                await _uploadImage();

                Map<String, dynamic> originalMap = {
                  'adptname': adptnameController.text,
                  'adptage': adptageController.text,
                  'adptaddress': adptaddressController.text,
                  'adptphone': adptphoneController.text,
                  'adpthouse': adpthouseController.text,
                  'adptexperience': adptexperienceController.text,
                  'adptreason': reasonController.text,
                };

                FirebaseFirestore.instance.collection('Adopter').add(originalMap);

                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Thank You"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Thank you"),
                          SizedBox(height: 10),
                          Image.asset('assets/images/thank-you.gif'),
                        ],
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            adptnameController.clear();
                            adptageController.clear();
                            adptaddressController.clear();
                            adptphoneController.clear();
                            adpthouseController.clear();
                            adptexperienceController.clear();
                            reasonController.clear();
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

void main() {
  runApp(MaterialApp(
    home: adopter(),
  ));
}
