import 'package:flutter/material.dart';
import 'package:petbuddy/health.dart';

import 'globals.dart';

class MyRoutine extends StatefulWidget {
  const MyRoutine({super.key, required String title});
  @override
  State<MyRoutine> createState() => _routineState();
}

class _routineState extends State<MyRoutine> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Pet"),
        ),
        body: Container(
            padding: EdgeInsets.all(20),
            child: ListView(children: [
              //name of pet
              Text('Breakfast Timing'),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: breakfastController,
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

              Text('Lunch Timing'),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: LunchtimeController,
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

              Text('Dinner Timing'),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: dinnerController,
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


              Text('Walking schedule (How many times per day)'),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: wDurationController,
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

              Text('Favorite food'),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: favFoodController,
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

              Text('Tips Regarding Food'),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: tipsFoodController,
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
                              return const MyHealth(title: 'health');
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