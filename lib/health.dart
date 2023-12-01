import 'package:flutter/material.dart';
import 'package:petbuddy/type.dart';

import 'globals.dart';

class MyHealth extends StatefulWidget {
  const MyHealth({super.key, required String title});
  @override
  State<MyHealth> createState() => _routineState();
}

class _routineState extends State<MyHealth> {
  int vaccineCompletedValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Pet"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Text('Vaccine completed'),
            SizedBox(height: 5),
            Row(
              children: [
                Radio(
                  value: 1,
                  groupValue: vaccineCompletedValue,
                  onChanged: (value) {
                    setState(() {
                      vaccineCompletedValue = (value as int?)!;
                      vaccineCompletedcontroller.text='Yes';
                    });
                  },
                ),
                SizedBox(width: 10.0),
                Text('Yes'),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: 2,
                  groupValue: vaccineCompletedValue,
                  onChanged: (value) {
                    setState(() {
                      vaccineCompletedValue = (value as int?)!;
                      vaccineCompletedcontroller.text='No';
                    });
                  },
                ),
                SizedBox(width: 10.0),
                Text('No'),
              ],
            ),
            SizedBox(height: 10),
            if (vaccineCompletedValue == 2) // Conditionally show the due vaccination field
              Column(
                children: [
                  Text('Due of vaccination (list them)'),
                  SizedBox(height: 5),
                  TextField(
                    controller: dueVaccineController,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      fillColor: Colors.blue.shade100,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            Text('Health issues'),
            SizedBox(height: 5),
            TextField(
              controller: healthController1,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                fillColor: Colors.blue.shade100,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              alignment: Alignment.bottomRight,
              child: CircleAvatar(
                //button to next page
                radius: 30,
                backgroundColor: Colors.blue[400],
                child: IconButton(
                  color: Colors.black,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return const MyType(title: 'type');
                      }),
                    );
                  },
                  icon: Icon(Icons.arrow_forward),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
