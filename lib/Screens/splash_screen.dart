// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:logistics/Screens/slider_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';

// ignore: use_key_in_widget_constructors
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var duration = const Duration(seconds: 2);
    return Timer(
      duration,
      navigationPage,
    );
  }

  Future navigationPage() async {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(seconds: 5),
        pageBuilder: (_, __, ___) => const SliderScreen(),
      ),
    );
  }

  @override
  void initState() {
    startTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: HexColor("297899"),
        ),
        child: Center(
          child: Image.asset(
            'assets/images/applogo.png',
            height: 500,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
