import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyPet {
  final String petreg;
  final String name;
  final String imageUrl;
  final String imagesUrl;
  final String address;
  final String breed;
  final String age;
  final String adpType;
  final String health1;
  final String fromdate;
  final String todate;
  final String brekfast_time;
  final String dinnertime;
  final String phone;
  final String lunchtime;
  final String vaccine1;
  final String dueVaccine;
  final String gender;
  final String owner;
  final String weight;
  final String favfood;
  final String tipsfood;
  final String w_duration;
  

  MyPet({
    required this.petreg,
    required this.name,
    required this.imageUrl,
    required this.imagesUrl,
    required this.address,
    required this.health1,
    required this.breed,
    required this.age,
    required this.adpType,
    required this.fromdate,
    required this.todate,
    required this.brekfast_time,
    required this.dinnertime,
    required this.phone,
    required this.lunchtime,
    required this.vaccine1,
    required this.dueVaccine,
    required this.gender,
    required this.owner,
    required this.weight,
    required this.favfood,
    required this.tipsfood,
    required this.w_duration,
  });



  factory MyPet.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data()!;
    return MyPet(
      petreg: data['petreg']?? '',
      name: data['name'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      imagesUrl: data['imagesUrl'] ?? '',
      breed: data['breed']?? '',
      age:data['age']?? '',
      address : data['address'] ?? '',
      adpType :data['adpType']?? '',
      fromdate :data['fromdate']?? '',//
      todate : data['todate']?? '',
      health1 : data['health1']?? '',
      brekfast_time : data['brekfast_time']?? '',
      dinnertime : data['dinnertime']?? '',
      lunchtime : data['lunchtime']?? '',
      phone : data['phone']?? '',
      vaccine1 : data['vaccine1']?? '',
      dueVaccine : data['dueVaccine']?? '',
      gender : data['gender']?? '',
      owner : data['owner']?? '',
      weight : data['weight']?? '',
      favfood : data['favfood']?? '',
      tipsfood :data['tipsfood']?? '',
      w_duration : data['w_duration']?? '',
      
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: MyPetListView(),
  ));
}

class MyPetListView extends StatefulWidget {
  @override
  _MyPetListViewState createState() => _MyPetListViewState();
}

class _MyPetListViewState extends State<MyPetListView> {
  late List<MyPet> myPets;

  @override
  void initState() {
    super.initState();
    fetchPetsFromFirebase();
  }

  Future<void> fetchPetsFromFirebase() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
    await FirebaseFirestore.instance.collection('Pets').get();

    setState(() {
      myPets = snapshot.docs
          .map((doc) => MyPet.fromFirestore(doc))
          .toList();
    });
  }

  Future<void> deletePetFromFirebase(String petreg) async {
    await FirebaseFirestore.instance.collection('Pets').doc(petreg).delete();
    setState(() {
      myPets.removeWhere((pet) => pet.petreg == petreg);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: myPets != null
          ? ListView.builder(
        itemCount: myPets.length,
        itemBuilder: (context, index) {
          return MyPetCard(
            myPet: myPets[index],
            onDelete: () => deletePetFromFirebase(myPets[index].petreg),
          );
        },
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class MyPetCard extends StatelessWidget {
  final MyPet myPet;
  final VoidCallback onDelete;

  const MyPetCard({
    required this.myPet,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Image.network(
            myPet.imageUrl,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(myPet.name),
        trailing: PopupMenuButton<String>(
          icon: Icon(Icons.more_vert),
          itemBuilder: (context) => [
            PopupMenuItem<String>(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit),
                  SizedBox(width: 8),
                  Text('Edit'),
                ],
              ),
            ),
            PopupMenuItem<String>(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete),
                  SizedBox(width: 8),
                  Text('Delete'),
                ],
              ),
            ),
            PopupMenuItem<String>(
              value: 'add_mating',
              child: Row(
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 8),
                  Text('Add for Mating'),
                ],
              ),
            ),
            PopupMenuItem<String>(
              value: 'add_adoption',
              child: Row(
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 8),
                  Text('Add for Adoption'),
                ],
              ),
            ),
          ],
          onSelected: (value) {
            if (value == 'edit') {
              // Navigate to edit details page
              // Pass myPet object or its petreg to the next page for editing
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditPetPage(myPet: myPet),
                ),
              );
            } else if (value == 'delete') {
              //deletePetFromFirebase(myPet.petreg);
              onDelete(); // Delete pet
            }
            // Handle other actions...
          },
        ),
      ),
    );
  }
}

class EditPetPage extends StatelessWidget {
  final MyPet myPet;

  const EditPetPage({required this.myPet});

  @override
  Widget build(BuildContext context) {
    // Implement editing details UI here
    // You can use TextEditingController for editing text fields, etc.
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Pet'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(height: 16.0),
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage(myPet.imageUrl),
                  ),
                  SizedBox(height: 16.0),
                  DataTable(
                    columnSpacing: 16.0,
                    columns: [
                      DataColumn(
                        label: Text(
                          ' ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          ' ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                    rows: [
                      DataRow(
                        cells: [
                          DataCell(
                            Text(
                              'Owner Name:',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              myPet.owner,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(
                            Text(
                              'Phone Number:',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              myPet.phone,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),

                      DataRow(
                        cells: [
                          DataCell(
                            Text(
                              'Name:',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              myPet.name,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(
                            Text(
                              'Pet Registration:',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              myPet.petreg,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),

                      DataRow(
                        cells: [
                          DataCell(
                            Text(
                              'Breed:',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              myPet.breed,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(
                            Text(
                              'Gender:',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              myPet.gender,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),


                      DataRow(
                        cells: [
                          DataCell(
                            Text(
                              'Pet Registration:',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              myPet.petreg,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),

                      DataRow(
                        cells: [
                          DataCell(
                            Text(
                              'Weight:',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              myPet.weight,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(
                            Text(
                              'AdpType:',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              myPet.adpType,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(
                            Text(
                              'From Date:',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              myPet.fromdate,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(
                            Text(
                              'To Date:',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              myPet.todate,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(
                            Text(
                              'BreakFast Time:',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              myPet.brekfast_time,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(
                            Text(
                              'Lunch Time:',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              myPet.lunchtime,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),


                      DataRow(
                        cells: [
                          DataCell(
                            Text(
                              'Dinner Time:',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              myPet.dinnertime,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(
                            Text(
                              'Vaccine:',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              myPet.vaccine1,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(
                            Text(
                              'Due Vaccine:',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              myPet.dueVaccine,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(
                            Text(
                              'Favorite Food',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              myPet.favfood,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(
                            Text(
                              'Tips Rgarding Food:',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              myPet.tipsfood,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(
                            Text(
                              'Walking Duration:',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              myPet.w_duration,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Divider(
              color: Colors.grey,
              thickness: 2.0,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Photos',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 16),
                  FutureBuilder(

                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error loading images');
                      } else if (snapshot.hasData) {
                        List<Widget> imageWidgets = snapshot.data as List<Widget>;
                        return Row(
                          children: [
                            for (Widget imageWidget in imageWidgets)
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: imageWidget,
                                ),
                              ),
                          ],
                        );
                      } else {
                        return Text('No images available');
                      }
                    },
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle interested button click here
              },
              child: Text('Interested'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
