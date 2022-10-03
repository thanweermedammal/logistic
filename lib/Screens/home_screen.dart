// ignore_for_file: prefer_const_constructors, prefer_final_fields, unused_field, avoid_unnecessary_containers, no_leading_underscores_for_local_identifiers

import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:logistics/Screens/add_consignment.dart';
import 'package:logistics/Screens/delivery_screen.dart';
import 'package:logistics/Screens/packages_menu.dart';
import 'package:logistics/Screens/pickup_acceptscreen.dart';
import 'package:logistics/Screens/pickup_screen.dart';
import 'package:logistics/Screens/searchbyid.dart';
import 'package:logistics/components/home/todaystask.dart';

import 'package:bottom_nav_bar/bottom_nav_bar.dart';
import 'package:logistics/controller/allshipment_controller.dart';
import 'package:http/http.dart' as http;
import 'package:logistics/models/login_model.dart';
import 'package:location/location.dart';
import 'package:logistics/models/packages_model.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:logistics/provider/listprovider.dart';
import 'package:provider/provider.dart';

import 'Home.dart';

class HomeScreen extends StatefulWidget {
  List<Login> loginList = [];

  HomeScreen(this.loginList);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _currentIndex = 0;
  List<Widget>? _widgetOptions;
  AllShipmentController allShipmentController =
      Get.put(AllShipmentController());

  @override
  void initState() {
    allShipmentController.fetchAllShipmentData(widget.loginList);
    _widgetOptions = [
      Home(widget.loginList),
      SearchById(
        loginList: widget.loginList,
      ),
      Text('Notification Page',
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    ];

    // TODO: implement initState
    super.initState();
  }

  bool isSwitched = true;

  void toggleSwitch(bool value) async {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
      });
    } else {
      setState(() {
        isSwitched = false;
      });
    }
    var response = await http.get(Uri.parse(
        'http://185.188.127.100/WaselleApi/api/Shipper/ChangeStatus?DriverId=${widget.loginList.first.dId}&BranchId=${widget.loginList.first.bId}&Status=$isSwitched'));
    if (response.statusCode == 200) {
      print(response.body);
      // print(Provider.of<DataProvider>(context).loginList![0].dId);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10.0),
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.menu,
              color: Colors.black,
            ),
          ),
          // ignore: prefer_const_literals_to_create_immutables
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                child: Switch(
                  onChanged: toggleSwitch,
                  value: isSwitched,
                  activeColor: HexColor('17aeb4'),
                  activeTrackColor: Colors.black,
                  inactiveThumbColor: Colors.grey,
                  inactiveTrackColor: Colors.grey,
                )),
          ],
        ),
        body: _widgetOptions!.elementAt(_currentIndex),
        bottomNavigationBar: BottomNavBar(
          showElevation: true,
          selectedIndex: _currentIndex,
          onItemSelected: (index) {
            setState(() => _currentIndex = index);
          },
          items: <BottomNavBarItem>[
            BottomNavBarItem(
              title: 'Home',
              icon: const Icon(Icons.home),
              activeColor: Colors.white,
              inactiveColor: Colors.black,
              activeBackgroundColor: Colors.blue.shade300,
            ),
            BottomNavBarItem(
              title: '',
              icon: Image.asset(
                "assets/images/bottom2.png",
                height: 40,
                color: Colors.black,
              ),
              activeColor: Colors.white,
              inactiveColor: Colors.black,
              activeBackgroundColor: Colors.blue.shade300,
            ),
            BottomNavBarItem(
              title: 'Notifications',
              icon: const Icon(Icons.notifications),
              inactiveColor: Colors.black,
              activeColor: Colors.white,
              activeBackgroundColor: Colors.blue.shade300,
            ),
          ],
        ));
  }
}
