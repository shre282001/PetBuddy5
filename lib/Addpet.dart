import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:petbuddy/globals.dart';

class addPet extends StatefulWidget {
  const addPet({Key? key}) : super(key: key);

  @override
  State<addPet> createState() => _addPetState();
}

class _addPetState extends State<addPet> {
  File? _image;
  // TextEditingController ownerController = TextEditingController();
  // TextEditingController phoneController = TextEditingController();
  // TextEditingController emailController = TextEditingController();
  // TextEditingController addressController = TextEditingController();

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });

      // Upload the image to Firebase Storage with a unique name
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('profile_pics/${DateTime.now()}.jpg');
      UploadTask uploadTask = storageReference.putFile(_image!);

      // Wait for the upload to complete and get the download URL
      String imageUrl = await (await uploadTask).ref.getDownloadURL();

      //Now you can save the imageUrl to Firestore
      // FirebaseFirestore.instance.collection('pets').add({
      //   'image_url': imageUrl,
      //   'owner': ownerController.text,
      //   'phone': phoneController.text,
      //   'email': emailController.text,
      //   'address': addressController.text,
      // });
      globalImageUrl=imageUrl;
      log(imageUrl,name: "Imageurl");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
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
            Text('Name of owner'),
            SizedBox(
              height: 5,
            ),
            TextField(
              controller: ownerController,
              style: TextStyle(color: Colors.black),
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
            Text('Phone'),
            SizedBox(
              height: 5,
            ),
            TextField(
              controller: phoneController,
              style: TextStyle(color: Colors.black),
              keyboardType: TextInputType.phone,
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
            Text('Email'),
            SizedBox(
              height: 5,
            ),
            TextField(
              controller: emailController,
              style: TextStyle(color: Colors.black),
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
            Text('Address'),
            SizedBox(
              height: 5,
            ),
            TextField(
              controller: addressController,
              style: TextStyle(color: Colors.black),
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
            Container(
              alignment: Alignment.bottomRight,
              child: CircleAvatar(
                //button to the next page
                radius: 30,
                backgroundColor: Colors.blue[400],
                child: IconButton(
                  color: Colors.black,
                  onPressed: () {
                    Navigator.pushNamed(context, 'preference');
                  },
                  icon: Icon(
                    Icons.arrow_forward,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
