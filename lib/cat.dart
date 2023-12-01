//cat
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String name;
  // final String description;
  final String imagePath;
  final String imagesPath;
  final String petreg;
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

  Product({
    required this.name,
    // required this.description,
    required this.imagePath,
    required this.imagesPath,
    required this.health1,
    required this.petreg,
    required this.breed,
    required this.age,
    required this.adpType,
    required this.fromdate,
    required this.todate,
    required this.address,
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
}

class catCard extends StatefulWidget {
  @override
  State<catCard> createState() => _catCardState();
}

class _catCardState extends State<catCard> {
  final List<Product> products = [];

  void getData() async {
    var snapshot =
    await FirebaseFirestore.instance.collection('Pets').where('type', isEqualTo: 'Cat').get();
    var documents = snapshot.docs;
    var newProducts = List<Product>.empty(growable: true);

    for (var doc in documents) {
      var name = doc.data()['name'];//
      var breed = doc.data()['breed'];//
      var age = doc.data()['age'];//
      var address = doc.data()['address'];//
      var adpType = doc.data()['adpType'];//
      var petreg = doc.data()['petreg'];//
      var fromdate = doc.data()['fromdate'];//
      var todate = doc.data()['todate'];//
      var health1 = doc.data()['health1'];//
      var brekfast_time = doc.data()['brekfast_time'];//
      var dinnertime = doc.data()['dinnertime'];//
      var lunchtime = doc.data()['lunchtime'];//
      var phone = doc.data()['phone'];//
      var vaccine1 = doc.data()['vaccine1'];//
      var dueVaccine = doc.data()['dueVaccine'];//
      var gender = doc.data()['gender'];//
      var owner = doc.data()['owner'];//
      var weight = doc.data()['weight'];
      var favfood = doc.data()['favfood'];//
      var tipsfood = doc.data()['tipsfood'];//
      var w_duration = doc.data()['w_duration'];//



      // var description = 'Breed: $breed\nAge: $age years\nAdpType: $adpType';

      var imagePath = doc["imageUrl"];
      var imagesPath = doc["imagesUrl"];
      // log(name,name:"name");
      // //log(description,name:"description");
      // log(breed??"debug",name:"breed");
      // log(age??"debug",name:"age");
      // log(adpType??"debug",name:"adpType");
      // log(fromdate??"debug",name:"fromdate");
      // log(todate??"debug",name:"todate");
      // log(brekfast_time??"debug",name:"brekfast_time");
      // log(dinnertime??"debug",name:"dinnertime");
      // log(phone??"Debug",name:"phone");
      // log(lunchtime??"Debug",name:"lunchtime");
      // log(vaccine1??"Debug",name:"vaccine1");
      // log(dueVaccine??"Debug",name:"dueVaccine");
      // log(gender??"Debug",name:"gender");
      // log(owner??"Debug",name:"owner");
      // log(weight??"Debug",name:"weight");
      // log(favfood??"Debug",name:"favfood");
      // log(tipsfood??"Debug",name:"tipsfood");
      // log(w_duration??"Debug",name:"w_duration");

      newProducts.add(Product(
        name: name,
        //description: description,
        imagePath: imagePath,
        imagesPath: imagesPath,
        petreg: petreg,
        breed: breed,
        address: address,
        age: age,
        health1: health1,
        adpType: adpType,
        fromdate: fromdate,
        todate: todate,
        brekfast_time: brekfast_time,
        dinnertime: dinnertime,
        phone: phone,
        lunchtime:lunchtime,
        vaccine1:vaccine1,
        dueVaccine:dueVaccine,
        gender:gender,
        owner:owner,
        weight:weight,
        favfood:favfood,
        tipsfood:tipsfood,
        w_duration:w_duration,
      ));
    }

    setState(() {
      products.addAll(newProducts);
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
      body: GridView.builder(
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.55,
        ),
        itemBuilder: (BuildContext context, int index) {
          return ProductCard(product: products[index]);
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
              child: Image.network(
                product.imagePath,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Text.rich(
                  TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: "Name: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: product.name,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4),
                Text.rich(
                  TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: "Breed: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: product.breed,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: "Age: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: product.age,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4),
                Text.rich(
                  TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: "Adoption Type: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: product.adpType,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage(product: product)),
                    );
                  },
                  child: Text('See Profile'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  final Product product;

  const ProfilePage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
        backgroundColor: Colors.blue,
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
                    backgroundImage: NetworkImage(product.imagePath),
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
                              product.owner,
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
                              product.phone,
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
                              product.name,
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
                              product.petreg,
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
                              product.breed,
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
                              product.gender,
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
                              product.petreg,
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
                              product.weight,
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
                              product.adpType,
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
                              product.fromdate,
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
                              product.todate,
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
                              product.brekfast_time,
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
                              product.lunchtime,
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
                              product.dinnertime,
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
                              product.vaccine1,
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
                              product.dueVaccine,
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
                              product.favfood,
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
                              product.tipsfood,
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
                              product.w_duration,
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
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            product.imagesPath,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            product.imagesPath,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Add more Image widgets here for displaying photos
                    ],
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

