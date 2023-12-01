import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart'; // Import Firebase Storage
import 'package:petbuddy/globals.dart';
import 'package:petbuddy/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: Rescue(),
  ));
}

class Rescue extends StatefulWidget {
  @override
  _RescueState createState() => _RescueState();
}

class _RescueState extends State<Rescue> {
  String name1 = "";
  String phoneNumber = "";
  String selectedAnimal = "";
  String imagePath = "";

  String currentLocation = "";
  String currentLocationLink = "";
  late GoogleMapController mapController;
  Set<Marker> markers = {};

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
      });
    }
  }

  Future<void> _getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        double latitude = position.latitude;
        double longitude = position.longitude;
        currentLocation = "Latitude: $latitude, Longitude: $longitude";
        currentLocationLink =
        "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";
        _updateMap(latitude, longitude);
      });
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  void _updateMap(double lat, double lng) {
    setState(() {
      markers.clear();
      markers.add(
        Marker(
          markerId: MarkerId("currentLocation"),
          position: LatLng(lat, lng),
          infoWindow: InfoWindow(
            title: "Current Location",
            snippet: "Lat: $lat, Lng: $lng",
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Text(
              "Name:",
              style: TextStyle(fontSize: 16),

            ),
            SizedBox(height: 10),
            TextField(
              controller: R_nameController,
              decoration: InputDecoration(
                hintText: 'Enter your name',
                fillColor: Colors.blue.shade100,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Phone Number:",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            TextField(
              controller: R_phoneNumberController,
              decoration: InputDecoration(
                hintText: 'Enter your phone number',
                fillColor: Colors.blue.shade100,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Select Pet Type:",
              style: TextStyle(fontSize: 16),
            ),
            Row(
              children: [
                Radio(
                  value: "Dog",
                  groupValue: selectedAnimal,
                  onChanged: (value) {
                    setState(() {
                      selectedAnimal = "Dog";
                    });
                  },
                ),
                Text("Dog"),
                Radio(
                  value: "Cat",
                  groupValue: selectedAnimal,
                  onChanged: (value) {
                    setState(() {
                      selectedAnimal = "Cat";
                    });
                  },
                ),
                Text("Cat"),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: Icon(Icons.camera_alt),
              label: Text("Open Camera"),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0), // You can adjust the radius value as needed
                ),
              ),
            ),
            if (imagePath.isNotEmpty)
              Container(
                width: 10,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(File(imagePath)),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _getLocation,
              icon: Icon(Icons.location_on),
              label: Text("Get Current Location"),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0), // You can adjust the radius value as needed
                ),
              ),
            ),
            // Display the location link if available.
            if (currentLocationLink.isNotEmpty)
              Text(
                "Location Link: $currentLocationLink",
                style: TextStyle(fontSize: 16),
              ),
            Container(
              height: 10,
              child: GoogleMap(
                onMapCreated: (GoogleMapController controller) {
                  setState(() {
                    mapController = controller;
                  });
                },
                initialCameraPosition: CameraPosition(
                  target: LatLng(0, 0),
                  zoom: 15.0,
                ),
                markers: markers,
              ),
            ),
            // if (currentLocation.isNotEmpty)
            //   Text(
            //     "Current Location: $currentLocation",
            //     style: TextStyle(fontSize: 16),
            //   ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                // Implement your logic to send the data
                _sendRescueData();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
              icon: Icon(Icons.send),
              label: Text("Send"),
            ),
          ],
        ),
      ),
    );
  }

  void _sendRescueData() async {
    // Get the user input from the text fields using the controllers.
    String name = R_nameController.text;
    String phone = R_phoneNumberController.text;

    String petType = selectedAnimal;
    String location = currentLocationLink;

    // Upload the image to Firebase Storage and get the download URL.
    String imageUrl = await _uploadImageToStorage();

    // Store the data in Firebase Firestore, including the image URL.
    await FirebaseFirestore.instance.collection("Rescue").add({
      "Name": name,
      "Phone Number": phone,
      "Pet Type": petType,
      "ImageURL": imageUrl,
      "Location": location,
    });
  }

  Future<String> _uploadImageToStorage() async {
    final storage = FirebaseStorage.instance;
    final Reference storageRef = storage.ref().child('Rescue/${DateTime.now()}.jpg');

    final UploadTask uploadTask = storageRef.putFile(File(imagePath));

    final TaskSnapshot download = await uploadTask;
    final String imageUrl = await download.ref.getDownloadURL();

    return imageUrl;
  }
}
