import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Trainer {
  final String T_name;
  final String T_profile_pic;
  final String T_phone_number;
  final String T_fees;
  final String T_certificate;

  Trainer({
    required this.T_profile_pic,
    required this.T_name,
    required this.T_phone_number,
    required this.T_fees,
    required this.T_certificate,
  });

  void makePhoneCall() async {
    String url = 'tel:${T_phone_number}';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class trainer_Page extends StatefulWidget {
  @override
  State<trainer_Page> createState() => _trainer_PageState();
}

class _trainer_PageState extends State<trainer_Page> {
  final List<Trainer> Trainers = [];

  void getData() async {
    var snapshot = await FirebaseFirestore.instance.collection('Trainer').get();
    var documents = snapshot.docs;
    var newTrainers = List<Trainer>.empty(growable: true);

    for (var doc in documents) {
      var T_name = doc['T_name'];
      var T_phone_number = doc['T_phone_number'];
      var T_fees = doc['T_fees'];
      var T_certificate = doc['T_certificate'];
      var T_profile_pic = doc['T_profile_pic'];

      newTrainers.add(Trainer(
        T_name: T_name,
        T_phone_number: T_phone_number,
        T_fees: T_fees,
        T_certificate: T_certificate,
        T_profile_pic: T_profile_pic,
      ));
    }
    setState(() {
      Trainers.addAll(newTrainers);
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
          stream: FirebaseFirestore.instance.collection('Trainer').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }

            List<Trainer> Trainers = [];
            snapshot.data!.docs.forEach((doc) {
              Trainers.add(Trainer(
                T_name: doc['T_name'],
                T_phone_number: doc['T_phone_number'],
                T_fees: doc['T_fees'],
                T_certificate: doc['T_certificate'],
                T_profile_pic: doc['T_profile_pic'],
              ));
            });

            return ListView.builder(
              itemCount: Trainers.length,
              itemBuilder: (BuildContext context, int index) {
                return TrainerCard(trainer: Trainers[index]);
              },
            );
          },
        ),
      ),
    );
  }
}

class TrainerCard extends StatelessWidget {
  final Trainer trainer;

  const TrainerCard({required this.trainer});

  @override
  Widget build(BuildContext context) {
    return Card(
     // color: Colors.white24, // Background color for the Card
      margin: EdgeInsets.all(8), // Margin around the entire card
      child: ListTile(
        contentPadding: EdgeInsets.all(16), // Padding for the content inside the card
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Image.network(
            trainer.T_profile_pic,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          trainer.T_name,
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
                0: FlexColumnWidth(1), // Adjust the column widths as needed
              },
              children: [
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        'Contact:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold, // Make the text bold
                          color: Colors.black, // Set text color
                        ),
                      ),
                    ),
                    Text(
                      trainer.T_phone_number,
                      style: TextStyle(
                        color: Colors.black, // Set text color
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        'Fees:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold, // Make the text bold
                          color: Colors.black, // Set text color
                        ),
                      ),
                    ),
                    Text(
                      trainer.T_fees,
                      style: TextStyle(
                        color: Colors.black, // Set text color
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
                trainer.makePhoneCall();
              },
            ),
          ],
        ),
      ),
    );
  }
}

