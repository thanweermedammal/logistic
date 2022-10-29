// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:get/get.dart';
import 'package:logistics/Screens/deliverVerify_screen.dart';
import 'package:logistics/components/delivery_card.dart';
import 'package:logistics/controller/allshipment_controller.dart';
import 'package:logistics/models/delivery_model.dart';
import 'package:logistics/models/deliverydetail_model.dart';
import 'package:logistics/models/login_model.dart';
import 'package:http/http.dart' as http;

class DeliveryScreen extends StatefulWidget {
  List<Login> loginList = [];
  DeliveryScreen({Key? key, required this.loginList}) : super(key: key);

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  List<dynamic> qrimages = [];
  List<DeliveryDetails> deliveryDetailslist = [];
  AllShipmentController allShipmentController =
      Get.put(AllShipmentController());
  String _scanBarcode = 'Unknown';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Stack(
                children: [
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(80),
                            bottomRight: Radius.circular(80),
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(0)),
                        child: Container(
                          height: 500,
                          width: MediaQuery.of(context).size.width,
                          color: HexColor('17B5BC'),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 60.0, left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Material(
                                      type: MaterialType.transparency,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Ink(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 2),
                                              // color: Colors.greenAccent,
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          child: InkWell(
                                            onTap: (() =>
                                                Navigator.pop(context)),
                                            child: Padding(
                                              padding: EdgeInsets.all(5.0),
                                              child: Icon(
                                                Icons.arrow_back_sharp,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // IconButton(
                                    //   onPressed: (() => Navigator.pop(context)),
                                    //   icon: Icon(
                                    //     Icons.arrow_back_sharp,
                                    //     color: Colors.white,
                                    //   ),
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Text(
                                              "Delivery",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 24,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Text(
                                              "Consignments",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 24,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 140, left: 20, right: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Hello ${widget.loginList.first.name},',
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        'Today\'s consignments has been assigned successfully',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 460, left: 71),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              height: 71,
                              width: 230,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_scanBarcode != 'Unknown') {
                                    if (_scanBarcode != '-1') {
                                      var response = await http.get(Uri.parse(
                                          'http://185.188.127.100/WaselleApi/api/Shipment/GetRunsheetDetails?DriverId=${widget.loginList.first.dId}&BranchId=${widget.loginList.first.bId}&RunsheetId=${_scanBarcode}'));
                                      final deliveryData =
                                          jsonDecode(response.body);
                                      if (response.statusCode == 200) {
                                        print('ok');

                                        setState(() {
                                          deliveryDetailslist =
                                              List<DeliveryDetails>.from(
                                                  deliveryData.map((x) =>
                                                      DeliveryDetails.fromJson(
                                                          x)));
                                        });
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DeliveryVerify(
                                                      deliveryDetailsList:
                                                          deliveryDetailslist,
                                                      loginList:
                                                          widget.loginList, runsheet: _scanBarcode,
                                                    )));
                                      }
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: HexColor('28759A'),
                                ),
                                child: Text(
                                  "Load Runsheet",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      String barcodeScanRes =
                          await FlutterBarcodeScanner.scanBarcode(
                              '#ff6666', 'Cancel', true, ScanMode.BARCODE);
                      setState(() {
                        _scanBarcode = barcodeScanRes;
                      });
                    },
                    child: Container(
                        height: 150,
                        width: 300,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Image.asset('assets/images/Rectangle 24.png'),
                              SizedBox(
                                height: 10,
                              ),
                              _scanBarcode == 'Unknown'
                                  ? Center(
                                      child: Text(
                                        'Scan Barcode',
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  : Center(
                                      child: Text(
                                        _scanBarcode,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
