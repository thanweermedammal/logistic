// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:logistics/Screens/home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:logistics/controller/allshipment_controller.dart';
import 'package:logistics/models/cusdetail.dart';
import 'package:logistics/models/login_model.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class PickAccept extends StatefulWidget {
  final custname;
  final shipid;
  final pickaddress;
  int index;
  List<Login> loginList = [];
  PickAccept({
    Key? key,
    required this.custname,
    required this.pickaddress,
    required this.shipid,
    required this.index,
    required this.loginList,
  }) : super(key: key);

  @override
  State<PickAccept> createState() => _PickAcceptState();
}

class _PickAcceptState extends State<PickAccept> {
  List<dynamic> images = [];
  List<dynamic> qrimages = [];
  String? imageString;
  String? data = "";
  bool loading = false;

  final now = DateTime.now();
  String _scanBarcode = 'Unknown';
  AllShipmentController allShipmentController =
      Get.put(AllShipmentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 20),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 100,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 11, 74, 14),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Row(
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    Text(
                                      "CustomerName : ",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      allShipmentController
                                          .allshipmentList![widget.index]
                                          .shipperName
                                          .toString()
                                      // customerDetail!.first.name.toString()
                                      ,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    Text(
                                      "Shipment ID : ",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      allShipmentController
                                              .allshipmentList![widget.index]
                                              .shipmentId
                                              .toString()
                                              .isEmpty
                                          ? ''
                                          : allShipmentController
                                              .allshipmentList![widget.index]
                                              .shipmentId
                                              .toString(),
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Pick Up Details ",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        "Pick Up Job Number : ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "12",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        "Company Name : ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Seek Pvt Ltd",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Icon(
                        Icons.location_on,
                      ),
                      Expanded(
                        child: Text(
                          widget.pickaddress,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Pick Up Date :  ${now.day}/${now.month}/${now.year}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Pick Up Time :   ${now.hour}:${now.minute} ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Expanded(
                        child: Text(
                          "From \n${widget.pickaddress}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          "To\n${allShipmentController.allshipmentList![widget.index].address}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                String barcodeScanRes =
                                    await FlutterBarcodeScanner.scanBarcode(
                                        '#ff6666',
                                        'Cancel',
                                        true,
                                        ScanMode.BARCODE);
                                setState(() {
                                  _scanBarcode = barcodeScanRes;
                                });
                              },
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                ),
                                child: _scanBarcode == 'Unknown'
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.document_scanner,
                                            size: 40,
                                            color: Colors.grey,
                                          ),
                                        ],
                                      )
                                    : Center(
                                        child: Text(_scanBarcode),
                                      ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Scan Barcode",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                images = [];
                                final XFile? image =
                                    await ImagePicker().pickImage(
                                        source: ImageSource.camera,
                                        // imageQuality: 0,
                                        maxHeight: 500,
                                        maxWidth: 400);
                                File imagefile =
                                    File(image!.path); //convert Path to File
                                print(imagefile);
                                Uint8List imagebytes =
                                    await imagefile.readAsBytes();
                                setState(() {
                                  images.add(File(image.path));
                                  imageString = base64.encode(imagebytes);
                                  print(imageString);
                                  // imagebytes1 = imagebytes;
                                });
                              },
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                ),
                                child: images.isEmpty
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.camera_alt,
                                            size: 40,
                                            color: Colors.grey,
                                          ),
                                        ],
                                      )
                                    : Image.file(
                                        images.first,
                                        fit: BoxFit.fill,
                                      ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Upload Image",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Expanded(
                        child: Text(
                          "Click Here to add\nSignature",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: Container(
                      height: 50,
                      width: 200,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_scanBarcode.isNotEmpty) {
                            setState(() {
                              loading = true;
                            });
                            var response = await http.post(
                                Uri.parse(
                                    "http://185.188.127.100/WaselleApi/api/Shipment/SaveProduct"),
                                headers: {
                                  "Accept": "application/json",
                                  "content-type": "application/json"
                                },
                                body: json.encode([
                                  {
                                    "ShipperId": allShipmentController
                                        .allshipmentList![widget.index]
                                        .shipperId,
                                    "ShipmentId": allShipmentController
                                        .allshipmentList![widget.index]
                                        .shipmentId,
                                    "Barcode": _scanBarcode == "Unknown"
                                        ? ''
                                        : _scanBarcode,
                                    "BranchId": widget.loginList.first.bId,
                                    "DriverId": widget.loginList.first.dId,
                                    "ProductName": 'item',
                                    "ShipperName": allShipmentController
                                        .allshipmentList![widget.index].name,
                                    "ShipperMobile":
                                        widget.loginList.first.mobile,
                                    "AmountRecieved": allShipmentController
                                        .allshipmentList![widget.index]
                                        .amountRecieved,
                                    "ImageString": imageString,
                                    "Status": 'Picked',
                                    "FromAddress": allShipmentController
                                        .allshipmentList![widget.index].address,
                                    "ToAddress": '',
                                    "LoggedUser": allShipmentController
                                        .allshipmentList![widget.index]
                                        .shipperName,
                                    "Date":
                                        '${now.year}-${now.month}-${now.day}',
                                  }
                                ]));
                            if (response.statusCode == 200) {
                              print(response.statusCode);
                              print(response.body);
                              final snackBar = SnackBar(
                                  content: Text(
                                      'Successfully Booked ${response.body}'));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              if (response.body != 0) {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        HomeScreen(widget.loginList),
                                  ),
                                  ModalRoute.withName('/'),
                                );
                              }
                            } else {
                              print(response.statusCode);
                              setState(() {
                                loading = false;
                              });
                            }
                          } else {
                            print('fill');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: HexColor('17aeb4'),
                        ),
                        child: loading == false
                            ? Text(
                                "Submit to Approve",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xffffffff),
                                ),
                              )
                            : LoadingIndicator(
                                indicatorType: Indicator.ballSpinFadeLoader,
                                colors: [Colors.white],
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
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
