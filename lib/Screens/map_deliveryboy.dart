// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logistics/Screens/pickup_acceptscreen.dart';
import 'package:logistics/controller/allshipment_controller.dart';
import 'package:logistics/models/login_model.dart';

class MapDelivery extends StatefulWidget {
  final custname;
  final shipid;
  final pickaddress;
  int index;
  List<Login> loginList = [];
  MapDelivery(
      {Key? key,
      required this.custname,
      required this.pickaddress,
      required this.shipid,
      required this.loginList,
      required this.index})
      : super(key: key);

  @override
  State<MapDelivery> createState() => _MapDeliveryState();
}

class _MapDeliveryState extends State<MapDelivery> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(9.9312, 76.2673);
  AllShipmentController allShipmentController =
      Get.put(AllShipmentController());

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 50),
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
            Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  "assets/images/Untitled design (3).gif",
                  fit: BoxFit.cover,
                )
                // GoogleMap(
                //   onMapCreated: _onMapCreated,
                //   initialCameraPosition: CameraPosition(
                //     target: _center,
                //     zoom: 15.0,
                //   ),
                // ),
                ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
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
                  builder: (context) => PickAccept(
                    custname: widget.custname,
                    shipid: widget.shipid,
                    pickaddress: widget.pickaddress,
                    loginList: widget.loginList,
                    index: widget.index,
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              primary: HexColor('17aeb4'),
            ),
            child: Text(
              "Pick up",
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
