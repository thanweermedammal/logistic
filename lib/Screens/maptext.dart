import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logistics/Screens/verificationdelivery.dart';
import 'package:logistics/models/deliverydetail_model.dart';
import 'package:logistics/models/login_model.dart';

class MapText extends StatefulWidget {
  List<DeliveryDetails> deliveryDetailsList = [];
  int index;
  final runsheet;
  List<Login> loginList = [];
  MapText(
      {Key? key,
      required this.deliveryDetailsList,
      required this.index,
      required this.runsheet,
      required this.loginList})
      : super(key: key);

  @override
  State<MapText> createState() => _MapTextState();
}

class _MapTextState extends State<MapText> {
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

  String googleAPiKey = "AIzaSyAJo7ZMx1xhvdFX4xZCWoz8RgJ4f-NOtHc";
  final Completer<GoogleMapController> _controller = Completer();
  // static LatLng? sourceLocation = initPos;
  static const LatLng destination = LatLng(23.614328, 58.545284);
  List<LatLng> polylineCoordinates = [];
  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPiKey,
        PointLatLng(initPos!.latitude, initPos!.longitude),
        PointLatLng(destination.latitude, destination.longitude));
    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getCurrentLoc();
    loadingMap = true;
    getPolyPoints();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // mapController.dispose();
    streamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50.0, left: 20),
            child: Material(
              type: MaterialType.transparency,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Ink(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 2),
                      // color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: InkWell(
                    onTap: (() => Navigator.pop(context)),
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.arrow_back_sharp,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          (loadingMap)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox(
                  height: MediaQuery.of(context).size.height - 105,
                  child: GoogleMap(
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
                      initialCameraPosition:
                          CameraPosition(target: initPos!, zoom: 13.5),
                      mapType: MapType.normal,
                      polylines: {
                        Polyline(
                          polylineId: PolylineId("route"),
                          points: polylineCoordinates,
                        ),
                      },
                      markers: {
                        // Marker(markerId: MarkerId("source"), position: initPos!),
                        Marker(
                            markerId: MarkerId("destination"),
                            position: destination),
                      }),
                ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width / 2,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(5),
          ),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VerificationDelivery(
                            deliveryDetailsList: widget.deliveryDetailsList,
                            index: widget.index,
                            loginList: widget.loginList,
                            runsheet: widget.runsheet,
                          )));
            },
            style: ElevatedButton.styleFrom(
              primary: HexColor('17aeb4'),
            ),
            child: Text(
              "Delivery",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xffffffff),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
