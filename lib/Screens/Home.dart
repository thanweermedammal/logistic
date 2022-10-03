import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logistics/Screens/delivery_screen.dart';
import 'package:logistics/Screens/packages_menu.dart';
import 'package:logistics/Screens/pickup_screen.dart';
import 'package:logistics/components/home/todaystask.dart';
import 'package:logistics/controller/allshipment_controller.dart';
import 'package:logistics/models/login_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';

class Home extends StatefulWidget {
  List<Login> loginList = [];
  Home(this.loginList);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late GoogleMapController mapController;
  LatLng? markerPos;
  LatLng? initPos;
  Set<Marker> markers = {};
  TextEditingController? searchPlaceController;
  bool loadingMap = false;
  bool init = true;
  bool loadingAddressDetails = false;
  String addressTitle = '';
  String locality = '';
  String city = '';
  String state = '';
  String pincode = '';

  // final LatLng _center = const LatLng(9.9312, 76.2673);
  StreamController<LatLng> streamController = StreamController();

  void fetchAddressDetail(LatLng location) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(location.latitude, location.longitude);
    addressTitle = placemarks[0].name!;
    locality = placemarks[0].locality!;
    city = placemarks[0].subLocality!;
    pincode = placemarks[0].postalCode!;
    state = placemarks[0].administrativeArea!;
  }

  final geolocator =
      Geolocator.getCurrentPosition(forceAndroidLocationManager: true);

  getCurrentLoc() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    initPos = LatLng(position.latitude, position.longitude);
    streamController.add(initPos as LatLng);
    setState(() {
      loadingMap = false;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  var location = loc.Location();

  AllShipmentController allShipmentController =
      Get.put(AllShipmentController());
  Future _checkGps() async {
    if (!await location.serviceEnabled()) {
      location.requestService();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allShipmentController.fetchAllShipmentData(widget.loginList);
    loadingMap = true;
    getCurrentLoc();
    searchPlaceController = TextEditingController();
    geolocator;
    _checkGps();
  }

  @override
  void dispose() {
    super.dispose();
    // mapController.dispose();
    streamController.close();
  }

  renderMap() {
    return SizedBox(
      height: 300,
      width: MediaQuery.of(context).size.width,
      child: (loadingMap)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GoogleMap(
              zoomControlsEnabled: false,
              myLocationEnabled: true,
              buildingsEnabled: true,
              indoorViewEnabled: false,
              onMapCreated: (controller) {
                mapController = controller;
                setState(() {
                  fetchAddressDetail(initPos!);
                });
              },
              onCameraMove: (CameraPosition pos) {
                streamController.add(pos.target);
              },
              initialCameraPosition: CameraPosition(
                target: initPos!,
                zoom: 15.0,
              ),
              mapType: MapType.normal,
            ),
    );
  }

  backButton() {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      color: Colors.black87,
      icon: const Icon(Icons.arrow_back),
    );
  }

  searchBox() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black87, width: 0.1),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(10),
      child: Center(
        child: TextFormField(
          controller: searchPlaceController,
          onChanged: (value) async {
            // ignore
          },
          decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(8),
              border: InputBorder.none,
              hintText: "Search Places...",
              labelStyle: TextStyle(color: Colors.black87)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 4, vsync: this);
    return RefreshIndicator(
      onRefresh: () async {
        _checkGps();

        allShipmentController.fetchAllShipmentData(widget.loginList);
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              color: HexColor('17aeb4'),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Icon(
                        Icons.message,
                        size: 30,
                        color: Colors.white,
                      )),
                  Text(
                    "You have new pickup request",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Today's Task",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TodaysTask(),
            // SizedBox(
            //   height: 10,
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 15),
            //   child: SizedBox(
            //     height: 300,
            //     child: GoogleMap(
            //       onMapCreated: _onMapCreated,
            //       initialCameraPosition: CameraPosition(
            //         target: _center,
            //         zoom: 15.0,
            //       ),
            //     ),
            //   ),
            // ),
            renderMap(),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Color.fromARGB(255, 11, 74, 14),
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PickUpRequest(
                                loginList: widget.loginList,
                              ),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Image.asset(
                              "assets/images/pickupicon.png",
                              height: 30,
                              color: Colors.pinkAccent,
                            ),
                            Text(
                              "Pickups",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DeliveryScreen(
                                loginList: widget.loginList,
                              ),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Image.asset(
                              "assets/images/delivery.png",
                              height: 32,
                              color: Colors.green,
                            ),
                            Text(
                              "Delivery",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Image.asset(
                            "assets/images/revenueicon.png",
                            height: 30,
                            color: Colors.orange,
                          ),
                          Text(
                            "Revenue",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Image.asset(
                            "assets/images/report.png",
                            height: 30,
                            color: Colors.red,
                          ),
                          Text(
                            "Report",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SizedBox(
                height: 75,
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    color: Color.fromARGB(255, 179, 233, 181),
                  ),
                  indicatorWeight: 5,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: Colors.black,
                  // ignore: prefer_const_literals_to_create_immutables
                  tabs: [
                    Tab(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Image.asset(
                            "assets/images/allicon.png",
                            height: 20,
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            "All",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Tab(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Image.asset(
                            "assets/images/pickupiccon.png",
                            height: 23,
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            "Pickup Requests",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 8,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Tab(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/accepted.png",
                            height: 25,
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            "Accepted",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 8,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Tab(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/deliveryicon.png",
                            height: 25,
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            "Delivery Jobs",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 8,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 1200,
              // ignore: prefer_const_literals_to_create_immutables

              child: Obx(() {
                if (allShipmentController.isloading.value) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return TabBarView(
                    // physics: const NeverScrollableScrollPhysics(),
                    controller: _tabController,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      PackagesMenu(
                        loginList: widget.loginList,
                      ),
                      PackagesMenu(
                        loginList: widget.loginList,
                      ),
                      PackagesMenu(
                        loginList: widget.loginList,
                      ),
                      PackagesMenu(
                        loginList: widget.loginList,
                      ),
                    ],
                  );
                }
              }),
            )
          ],
        ),
      ),
    );
  }
}
