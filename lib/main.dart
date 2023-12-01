import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:petbuddy/login.dart';
import 'package:petbuddy/register.dart';
import 'package:petbuddy/verify.dart';
import 'package:petbuddy/home.dart';
import 'Addpet.dart';
import 'dashboard.dart';
//import 'dogprofile.dart';
import 'feedback.dart';
import 'preference.dart';
import 'routine.dart';
import 'health.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyPhone(),
    routes: {
      'register': (context) => MyRegister(),
      'feedback': (context) => FeedbackForm(),
      'verify': (context) => MyVerify(),
      'home': (context) => HomePage(),
      'dashboard': (context) => DashboardPage(),
       //'dogprofile' :(context) => DogProfilePage(),
      'login': (context) => MyPhone(),
      'Addpet': (context) => addPet(),
      'preference': (context) => const MyPreference(),
      'routine': (context) => MyRoutine(

            title: 'routine',
          ),


    },
  ));
}
