import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petbuddy/main.dart';

import 'login.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 8),(){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context)=> MyPhone()
          ));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(

          child:Container(
              width: 100,
              height: 100,
              child: Image.asset('assets/images/pawprint.gif')) ,
        )

    );


  }
}