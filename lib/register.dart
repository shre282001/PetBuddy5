import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  TextEditingController regnameController = TextEditingController();
  TextEditingController regphoneController = TextEditingController();
  TextEditingController regemailController = TextEditingController();
  TextEditingController regAddressController = TextEditingController();

  String selectedGender = 'Male'; // Default gender selection
  String selectedAddressType = 'Home'; // Default address type selection
  bool isChecked = false; // Checkbox state

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _showTermsAndConditionsPopup(context);
    });
  }

  Future<void> _showTermsAndConditionsPopup(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false, // Prevents dismissing on tap outside the dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Terms and Conditions'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Please read and accept the terms and conditions',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value ?? false;
                      });
                    },
                  ),
                  Text('I agree'),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (isChecked) {
                  Navigator.of(context).pop(); // Close the dialog if checkbox is checked
                }
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Create Account',
              style: TextStyle(
                color: Colors.lightBlueAccent,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            Column(
              children: [
                TextFormField(
                  controller: regnameController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: regphoneController,
                  style: TextStyle(color: Colors.black),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Phone Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: regemailController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Radio(
                      value: 'Male',
                      groupValue: selectedGender,
                      onChanged: (value) {
                        setState(() {
                          selectedGender = 'Male';
                        });
                      },
                    ),
                    Text('Male'),
                    SizedBox(width: 20),
                    Radio(
                      value: 'Female',
                      groupValue: selectedGender,
                      onChanged: (value) {
                        setState(() {
                          selectedGender = 'Female';
                        });
                      },
                    ),
                    Text('Female'),
                  ],
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: regAddressController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: isChecked // Enable button only if checkbox is checked
                      ? () async {
                    Map<String, dynamic> originalMap = {
                      'regname': regnameController.text,
                      'regnumber': regphoneController.text,
                      'regemail': regemailController.text,
                      'Gender': selectedGender,
                      'address': regAddressController.text,
                    };

                    Navigator.pushNamed(context, 'login');

                    // Add data to the 'Register' collection
                    await FirebaseFirestore.instance
                        .collection('Register')
                        .add(originalMap);

                    // Fetch the data from Firestore and show it
                    var querySnapshot = await FirebaseFirestore.instance
                        .collection('Register')
                        .get();

                    querySnapshot.docs.forEach((doc) {
                      print(doc.data());
                    });

                    // Now you can navigate to other screens or perform other actions
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                TextButton(
                  onPressed: () {
                    // Navigate to the sign-in screen
                    Navigator.pushNamed(context, 'login');
                  },
                  child: Text(
                    'Sign In',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.lightBlueAccent,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
