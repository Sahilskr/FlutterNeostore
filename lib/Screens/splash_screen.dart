import 'dart:async';

import 'package:NeoStore/session.dart';
import 'package:flutter/material.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 2),
            () =>
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => Session())));
    return Scaffold(
      body:  Center(
        child: Text("NeoStore",
            style: TextStyle(
                color: Colors.teal,
                fontSize: 50,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w900)),
      ),
    );

  }
}