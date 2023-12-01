import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:petbuddy/aquatic.dart';
import 'package:petbuddy/birds.dart';
import 'package:petbuddy/cat.dart';
import 'package:petbuddy/dog.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String searchText = '';
  double sliderValue = 0;
  int _currentImageIndex = 0;

  final List<Widget> tabs = [
    Container(
      margin: EdgeInsets.all(16.0), // Add margin as needed
      child: dogCard(),
    ),
    Container(
      margin: EdgeInsets.all(16.0), // Add margin as needed
      child: catCard(),
    ),
  ];
  List<String> imageUrls = [];

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      setState(() {}); // Ensure Firebase is initialized before using it
    });
  }

  Future<List<String>> fetchImageUrlsFromFirestore() async {
    List<String> imageUrls = [];

    final firestore = FirebaseFirestore.instance;

    try {
      QuerySnapshot querySnapshot =
      await firestore.collection("Advertisement").get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        // Assuming your Firestore document has an "imageUrl" field
        final String imageUrl = data['img'];

        imageUrls.add(imageUrl);
      }
    } catch (e) {
      print("Error fetching data from Firestore: $e");
    }
    //  log(imageUrls.toString(),name: "List of images recieved from function");

    return imageUrls;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: tabs.length,
        child: Column(
          children: <Widget>[
            FutureBuilder(
                future: fetchImageUrlsFromFirestore(),
                builder: (context, snapshot) {
                  List<String> imageList = snapshot.data as List<String>;
                //  log(imageList.toString(),name:"listed data");

                  return CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentImageIndex = index;
                        });
                      },
                    ),
                    items: imageList.map((imageUrl) {
                      return Image.network(imageUrl);
                    }).toList(),
                  );
                }),
            SizedBox(height: 20),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: List<Widget>.generate(
            //     4, // Replace with the number of images in the slider
            //         (index) {
            //       return Container(
            //         width: 10.0,
            //         height: 10.0,
            //         margin: EdgeInsets.symmetric(horizontal: 5.0),
            //         decoration: BoxDecoration(
            //           shape: BoxShape.circle,
            //           color: _currentImageIndex == index
            //               ? Colors.blue
            //               : Colors.black,
            //         ),
            //       );
            //     },
            //   ),
            // ),
            SizedBox(height: 15),
            TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.black54,
              tabs: [
                Tab(text: 'Dog'),
                Tab(text: 'Cat'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: tabs,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
