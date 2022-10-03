// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'dart:convert';

import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:get/get.dart';
import 'package:logistics/Screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logistics/models/customer_model.dart';
import 'package:logistics/models/login_model.dart';
import 'package:logistics/provider/listprovider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  List<Login> loginList = [];

  login() async {
    var response = await http.get(Uri.parse(
        'http://185.188.127.100/WaselleApi/api/LoginDetails?UName=${userNameController.text}&Password=${passwordController.text}&UserType=Driver'));
    if (response.statusCode == 200) {
      final loginData = jsonDecode(response.body);
      print(response.statusCode);
      loginList = List<Login>.from(loginData.map((x) => Login.fromJson(x)));

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            loginList,
          ),
        ),
      );
    } else {
      print('wrong password or username');
      final snackBar = SnackBar(content: Text('Wrong Username or Password'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "assets/images/loginlogo.png",
                    height: 200,
                    color: HexColor("297899"),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextFormField(
                  // validator: phoneValidator,
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.green,
                  controller: userNameController,
                  onChanged: (text) {
                    // mobileNumber = value;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    contentPadding: EdgeInsets.all(10),
                    focusColor: Colors.greenAccent,
                    // labelStyle: ktext14,
                    labelText: "Username",
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                          color: Colors.black,
                        )),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextFormField(
                  obscureText: true,
                  // validator: phoneValidator,
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.green,
                  controller: passwordController,
                  onChanged: (text) {
                    // mobileNumber = value;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    contentPadding: EdgeInsets.all(10),
                    focusColor: Colors.greenAccent,
                    // labelStyle: ktext14,
                    labelText: "Password",
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                          color: Colors.black,
                        )),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Forgot Password?",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 144, 147, 148),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      login();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HexColor('17aeb4'),
                    ),
                    child: Text(
                      "Log In",
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
