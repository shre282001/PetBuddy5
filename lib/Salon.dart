import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Salon {
  final S_name;
  final S_profile_pic;
  final S_phone_number;
  final S_Address;
  final S_licence;
  final S_availableTime;

  Salon({
    required this.S_profile_pic,
    required this.S_name,
    required this.S_phone_number,
    required this.S_Address,
    required this.S_licence,
    required this.S_availableTime,
  });

  void makePhoneCall() async {
    String url = 'tel:${S_phone_number}';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class salon_Page extends StatefulWidget {
  @override
  State<salon_Page> createState() => _salon_PageState();
}

class _salon_PageState extends State<salon_Page> {
  final List<Salon> Salons = [];

  void getData() async {
    var snapshot = await FirebaseFirestore.instance.collection('Salon').get();
    var documents = snapshot.docs;
    var newSalons = List<Salon>.empty(growable: true);

    for (var doc in documents) {
      var S_name = doc['S_name'];
      var S_phone_number = doc['S_phone_number'];
      var S_Address = doc['S_Address'];
      var S_licence = doc['S_licence'];
      var S_availableTime = doc['S_availableTime'];
      var S_profile_pic = doc['S_profile_pic'];

      newSalons.add(Salon(
        S_name: S_name,
        S_phone_number: S_phone_number,
        S_Address: S_Address,
        S_licence: S_licence,
        S_profile_pic: S_profile_pic,
        S_availableTime: S_availableTime,
      ));
    }
    setState(() {
      Salons.addAll(newSalons);
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
        color: Colors.black12,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Salon').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            List<Salon> Salons = [];
            snapshot.data!.docs.forEach((doc) {
              Salons.add(Salon(
                S_name: doc['S_name'],
                S_phone_number: doc['S_phone_number'],
                S_Address: doc['S_Address'],
                S_licence: doc['S_licence'],
                S_profile_pic: doc['S_profile_pic'],
                S_availableTime: doc['S_availableTime'],
              ));
            });

            return ListView.builder(
              itemCount: Salons.length,
              itemBuilder: (BuildContext context, int index) {
                return SalonCard(salon: Salons[index]);
              },
            );
          },
        ),
      ),
    );
  }
}

class SalonCard extends StatelessWidget {
  final Salon salon;

  const SalonCard({required this.salon});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(6),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Image.network(
            salon.S_profile_pic,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          salon.S_name,
          style: TextStyle(
            fontWeight: FontWeight.bold, // Make the text bold
            color: Colors.blue, // Set text color
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Table(
              columnWidths: {
                0: FlexColumnWidth(1),
              },
              children: [
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        'Contact:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      salon.S_phone_number,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right:8),
                      child: Text(
                        'Address:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      salon.S_Address,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
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
                salon.makePhoneCall();
              },
            ),
          ],
        ),
      ),
    );
  }
}


