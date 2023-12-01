import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class Doctor {
  final String name;
  final String profilePic;
  final String phoneNumber;
  final google_map;
  final String clinicAddress;
  final String availableTime;
  final String city;

  Doctor({
    required this.name,
    required this.phoneNumber,
    required this.clinicAddress,
    required this.availableTime,
    required this.profilePic,
    required this.google_map,
    required this.city,
  });

  void makePhoneCall() async {
    String url = 'tel:$phoneNumber';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void openMap() async {
    String url = 'Map:$google_map';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class dr_concertPage extends StatefulWidget {
  @override
  State<dr_concertPage> createState() => _dr_concertPageState();
}

class _dr_concertPageState extends State<dr_concertPage> {
  final List<Doctor> doctors = [];

  void getData() async {
    var snapshot = await FirebaseFirestore.instance.collection('Doctor').get();
    var documents = snapshot.docs;
    var newDoctors = List<Doctor>.empty(growable: true);

    for (var doc in documents) {
      var name = doc['name'];
      var phoneNumber = doc['phoneNumber'];
      var clinicAddress = doc['clinicAddress'];
      var availableTime = doc['availableTime'];
      var profilePic = doc['imageUrldr'];
      var city = doc['city'];
      var google_map = doc['google_map'];

      newDoctors.add(Doctor(
        name: name,
        phoneNumber: phoneNumber,
        clinicAddress: clinicAddress,
        availableTime: availableTime,
        profilePic: profilePic,
        city: city,
        google_map: google_map,
      ));
    }

    // Merge the newDoctors list with the existing Doctors list
    setState(() {
      doctors.addAll(newDoctors);
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black12, // Background color for the ListView
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Doctor').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }

            List<Doctor> doctors = [];
            snapshot.data!.docs.forEach((doc) {
              doctors.add(Doctor(
                name: doc['name'],
                phoneNumber: doc['phoneNumber'],
                availableTime: doc['availableTime'],
                clinicAddress: doc['clinicAddress'],
                profilePic: doc['imageUrldr'],
                google_map: doc['google_map'],
                city: doc['city'],
              ));
            });

            return ListView.builder(
              itemCount: doctors.length,
              itemBuilder: (BuildContext context, int index) {
                return DoctorCard(doctor: doctors[index]);
              },
            );
          },
        ),
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  final Doctor doctor;

  const DoctorCard({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(6), // Margin around the entire card
      child: ListTile(
        contentPadding: EdgeInsets.all(16), // Padding for the content inside the card
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Image.network(
            doctor.profilePic,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          doctor.name,
          style: TextStyle(
            fontWeight: FontWeight.bold, // Make the text bold
            color: Colors.blue, // Set text color
          ),
        ),
        subtitle: Table(
          columnWidths: {
            0: FlexColumnWidth(1),
          },
          children: [
            TableRow(
              children: [
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      "Contact:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                TableCell(
                  child: Text(
                    doctor.phoneNumber,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      "Address:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                TableCell(
                  child: Text(
                    doctor.clinicAddress,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      "Time:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                TableCell(
                  child: Text(
                    doctor.availableTime,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.phone),
              onPressed: () {
                doctor.makePhoneCall();
              },
            ),
            IconButton(
              icon: Icon(Icons.location_on_sharp),
              onPressed: () {
                doctor.openMap();
              },
            ),
            // Add more actions/icons here if needed
          ],
        ),
      ),
    );
  }
}


