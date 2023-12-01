import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petbuddy/globals.dart';
import 'routine.dart';

class MyPreference extends StatefulWidget {
  const MyPreference({super.key});
  @override
  State<MyPreference> createState() => _personalState();
}

class _personalState extends State<MyPreference> {
  int _typeValue = 0;
  int _genderValue = 0;
  void _storeSelectedOptions() {
    String selectedType = _typeValue == 1 ? 'Dog' : 'Cat'   'Bird'   'Fish';

    String selectedGender = _genderValue == 5 ? 'Male' : 'Female';

    // Store the selected values in Firestore
    FirebaseFirestore.instance.collection('SelectedOptions').add({
      'type': selectedType,
      'gender': selectedGender,
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("Add Pet"),
        ),
        body: Container(
            padding: EdgeInsets.all(20),
            child: ListView(children: [
              Text('Pet Registration No.'),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: regnumbetController,
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
              //name of pet
              Text('Name'),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: nameController,
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
              //type og pet *******************************
              Text('Type of pet'),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Radio(
                 //   controller: typeController,
                    value: 1,
                    groupValue: _typeValue,
                    onChanged: (value) {
                      setState(() {
                        _typeValue = (value as int?)!;
                        typeController.text = 'Dog';
                      });
                    },
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('Dog'),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: 2,
                    groupValue: _typeValue,
                    onChanged: (value) {
                      setState(() {
                        _typeValue = (value as int?)!;
                        typeController.text = 'Cat';
                      });
                    },
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('Cat'),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: 3,
                    groupValue: _typeValue,
                    onChanged: (value) {
                      setState(() {
                        _typeValue = (value as int?)!;
                        typeController.text = 'Bird';
                      });
                    },
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('Bird'),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: 4,
                    groupValue: _typeValue,
                    onChanged: (value) {
                      setState(() {
                        _typeValue = (value as int?)!;
                        typeController.text = 'Fish';
                      });
                    },
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('Fish'),
                ],
              ),

              SizedBox(
                height: 10,
              ),
              //breed
              Text('Breed'),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: breedController,
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
              //weight
              Text('Weight'),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: weightController,
                style: TextStyle(color: Colors.black),
                keyboardType: TextInputType.number, // Set the keyboard type to number
                inputFormatters: [FilteringTextInputFormatter.digitsOnly], // Allow only digits
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
              //gender
              Text('Gender'),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Radio(

                      value: 5,
                      groupValue: _genderValue,
                      onChanged: (value) {
                        setState(() {
                          _genderValue = (value as int?)!;
                          genderController.text='Male';
                        });
                      }),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('Male'),
                ],
              ),
              Row(
                children: [
                  Radio(
                      value: 6,
                      groupValue: _genderValue,
                      onChanged: (value) {
                        setState(() {
                          _genderValue = (value as int?)!;
                          genderController.text='Female';
                        });
                      }),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('Female'),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              //age
              Text('Age of pet'),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: petageController,
                style: TextStyle(color: Colors.black),
                keyboardType: TextInputType.number, // Set the keyboard type to number
                inputFormatters: [FilteringTextInputFormatter.digitsOnly], // Allow only digits
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
                  //button to next page
                  radius: 30,
                  backgroundColor: Colors.blue[400],
                  child: IconButton(
                      color: Colors.black,
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const MyRoutine(title: 'routine');
                        }));
                      },
                      icon: Icon(
                        Icons.arrow_forward,
                      )),
                ),
              )
            ])));
  }
}

class Strings {}
