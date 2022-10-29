// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:logistics/Screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget drawer(@required loginList, @required context) {
  return Drawer(
    backgroundColor: HexColor('17aeb4'),
    child: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Container(
                      transform: Matrix4.translationValues(0, -50, 0),
                      child: SizedBox(
                        height: 80,
                        width: 80,
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(Icons.person)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Branch ID   :   ${loginList.first.bId}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Driver ID     :   ${loginList.first.dId}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Driver Name :   ${loginList.first.name}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.people_outline,
                        color: Colors.white,
                        size: 25.0,
                      ),
                    ),
                    title: Text(
                      "Shipper Contact",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    // onTap: () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => MyOrders(),
                    //     ),
                    //   );
                    // },
                  ),
                  ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.rule,
                        color: Colors.white,
                        size: 25.0,
                      ),
                    ),
                    title: Text(
                      "Terms & Conditions",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    // onTap: () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => MyOrders(),
                    //     ),
                    //   );
                    // },
                  ),
                  ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.settings,
                        color: Colors.white,
                        size: 25.0,
                      ),
                    ),
                    title: Text(
                      "Settings",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    // onTap: () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => MyOrders(),
                    //     ),
                    //   );
                    // },
                  ),
                  SizedBox(
                    height: 200,
                  ),
                  ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.logout,
                        color: Colors.white,
                        size: 25.0,
                      ),
                    ),
                    title: Text(
                      "Logout",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString("userName", '');
                      prefs.setString("password", '');
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                          (route) => false);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
