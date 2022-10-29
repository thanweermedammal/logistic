// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'dart:convert';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:logistics/Screens/login.dart';
import 'package:logistics/Screens/slider_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:logistics/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'home_screen.dart';

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
      checkFirstSeen,
    );
  }

  // navigationPage() async {
  //   Navigator.of(context).pushReplacement(
  //     PageRouteBuilder(
  //       transitionDuration: const Duration(seconds: 5),
  //       pageBuilder: (_, __, ___) => checkFirstSeen(),
  //     ),
  //   );
  // }

  @override
  void initState() {
    startTime();
    super.initState();
  }

  List<Login> loginList = [];

  checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      if (prefs.getString("userName") == null ||
          prefs.getString("userName") == '') {
        Navigator.of(context).pushReplacement(
            new MaterialPageRoute(builder: (context) => new LoginScreen()));
      } else {
        var response = await http.get(Uri.parse(
            'http://185.188.127.100/WaselleApi/api/LoginDetails?UName=${prefs.getString("userName")}&Password=${prefs.getString("password")}&UserType=Driver'));
        if (response.statusCode == 200) {
          final loginData = jsonDecode(response.body);
          print(response.statusCode);
          loginList = List<Login>.from(loginData.map((x) => Login.fromJson(x)));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(
                loginList,
              ),
            ),
          );
        }
      }
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new SliderScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: HexColor("947FEC"),
        ),
        child: Center(
          child: Image.asset(
            'assets/images/Rectangle 2.png',
            height: 500,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
