// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:logistics/controller/allshipment_controller.dart';
import 'package:logistics/models/customerdetails.dart';
import 'package:logistics/models/login_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddConsignment extends StatefulWidget {
  List<Login> loginList = [];
  List<CustomerDetails> customerDetailList = [];
  int index;
  AddConsignment(
      {Key? key,
      required this.loginList,
      required this.customerDetailList,
      required this.index})
      : super(key: key);

  @override
  State<AddConsignment> createState() => _AddConsignmentState();
}

class _AddConsignmentState extends State<AddConsignment> {
  var selectedIndexes = [];
  List<dynamic> images = [];
  List<dynamic> qrimages = [];
  List details = [];
  String? imageString;
  String? data = "";
  final now = DateTime.now();
  bool partialcheck = false;
  bool loading = false;
  String _scanBarcode = 'Unknown';
  AllShipmentController allShipmentController =
      Get.put(AllShipmentController());
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController itemController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  bool yescheck = true;
  bool nocheck = false;
  // String jsonData;

  postShipment() async {
    String jsonData;
    jsonData = json.encode(details);
    var response = await http.post(
        Uri.parse(
            "http://185.188.127.100/WaselleApi/api/Shipment/SaveFlashShipment"),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonData);

    if (response.statusCode == 200) {
      // var data = jsonDecode(response.body);
      final snackBar =
          SnackBar(content: Text('Successfully Booked ${response.body}'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print(widget.customerDetailList[widget.index].shipperId);
      print(itemController.text);
      print(response.body);
      print(_scanBarcode == "Unknown" ? '' : _scanBarcode);
      print(widget.loginList.first.bId);
      print(widget.loginList.first.dId);
      print(itemController.text);
      print(widget.customerDetailList[widget.index].name);
      print(widget.customerDetailList[widget.index].mobile);
      print(amountController.text);
      print(firstNameController.text);
      print(lastNameController.text);
      print(address1Controller.text);
      print(cityController.text);
      print(zipCodeController.text);
      print(contactController.text);
      print(yescheck == false ? 0 : amountController.text);
      print(yescheck.toString());
      print(widget.loginList.first.name);
      if (response.body != 0) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => AddConsignment(
                      loginList: widget.loginList,
                      customerDetailList: widget.customerDetailList,
                      index: widget.index,
                    )));
        print(response.body);
      }
    } else {
      print(response.statusCode);
      print('failed');
      setState(() {
        loading = false;
      });
    }
  }

  ImgDecode(index) {
    Uint8List bytes = base64.decode(details[index]["ImageString"]);
    return bytes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (() => Navigator.pop(context)),
          icon: Icon(
            Icons.arrow_back_sharp,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: details.length,
                  itemBuilder: (context, index) => Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(1, 1),
                              blurRadius: 3,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Name : ${details[index]["RecieverName"]}',
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        details.removeAt(index);
                                      });
                                    },
                                    child: Icon(
                                      Icons.delete_outline,
                                      color: Colors.red,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Address : ${details[index]["RecieverAddress1"]}',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'City : ${details[index]["RecieverCity"]}',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Zip Code : ${details[index]["RecieveZip"]}',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Cod Amount : ${details[index]["CODAmount"]}',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            offset: Offset(1, 1),
                                            blurRadius: 3,
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                          child:
                                              Text(details[index]["Barcode"])),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            offset: Offset(1, 1),
                                            blurRadius: 3,
                                          ),
                                        ],
                                      ),
                                      child: Image.memory(
                                        ImgDecode(index),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )),

              SizedBox(
                height: 10,
              ),
              Text(
                "Reciever Info",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Total Orders  : ${details.length}",
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  "First Name",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        // validator: phoneValidator,

                        keyboardType: TextInputType.text,
                        cursorColor: Colors.green,
                        controller: firstNameController,
                        onChanged: (text) {
                          // mobileNumber = value;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          focusColor: Colors.greenAccent,
                          // labelStyle: ktext14,
                          // labelText: "First Name",
                          labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                color: Colors.black,
                              )),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  "Last Name",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        // validator: phoneValidator,
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.green,
                        controller: lastNameController,
                        onChanged: (text) {
                          // mobileNumber = value;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          focusColor: Colors.greenAccent,
                          // labelStyle: ktext14,
                          // labelText: "Last Name",
                          labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                color: Colors.black,
                              )),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  "Address",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  // validator: phoneValidator,
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.green,
                  controller: address1Controller,
                  onChanged: (text) {
                    // mobileNumber = value;
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    focusColor: Colors.greenAccent,
                    // labelStyle: ktext14,
                    // labelText: "Address Line1",
                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
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

              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "ZipCode",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: TextFormField(
                                  // validator: phoneValidator,
                                  keyboardType: TextInputType.text,
                                  cursorColor: Colors.green,
                                  controller: zipCodeController,
                                  onChanged: (text) {
                                    // mobileNumber = value;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10),
                                    focusColor: Colors.greenAccent,
                                    // labelStyle: ktext14,
                                    // labelText: "Zip Code",
                                    labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        )),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "City",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: TextFormField(
                                  // validator: phoneValidator,
                                  keyboardType: TextInputType.text,
                                  cursorColor: Colors.green,
                                  controller: cityController,
                                  onChanged: (text) {
                                    // mobileNumber = value;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10),
                                    focusColor: Colors.greenAccent,
                                    // labelStyle: ktext14,
                                    // labelText: "City",
                                    labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        )),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
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
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  "Contact Number",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    color: HexColor('17aeb4'),
                    child: Icon(
                      Icons.phone_enabled_outlined,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        // validator: phoneValidator,
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.green,
                        controller: contactController,
                        onChanged: (text) {
                          // mobileNumber = value;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          focusColor: Colors.greenAccent,
                          // labelStyle: ktext14,
                          // labelText: "Contact Details (mandatory)",
                          labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                color: Colors.black,
                              )),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  "Alternative Number",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    color: HexColor('17aeb4'),
                    child: Icon(
                      Icons.phone_enabled_outlined,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        // validator: phoneValidator,
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.green,
                        // controller: _phoneController,
                        onChanged: (text) {
                          // mobileNumber = value;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          focusColor: Colors.greenAccent,
                          // labelStyle: ktext14,

                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                color: Colors.black,
                              )),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "COD",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Checkbox(
                                  value: yescheck,
                                  onChanged: (bool? newvalue) {
                                    setState(() {
                                      yescheck = true;
                                      if (yescheck == true) {
                                        nocheck = false;
                                        partialcheck = false;
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Paid",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Checkbox(
                                  value: nocheck,
                                  onChanged: (bool? newvalue) {
                                    setState(() {
                                      nocheck = true;
                                      if (nocheck == true) {
                                        yescheck = false;
                                        partialcheck = false;
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Partial",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Checkbox(
                                  value: partialcheck,
                                  onChanged: (bool? newvalue) {
                                    setState(() {
                                      partialcheck = true;
                                      if (partialcheck == true) {
                                        yescheck = false;
                                        nocheck = false;
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        )),
                  ),
                ],
              ),
              if (yescheck == true)
                Row(
                  children: [
                    SizedBox(
                      width: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Center(
                          child: Text(
                            "Amount ( OMR )",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextFormField(
                          // validator: phoneValidator,
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.green,
                          controller: amountController,
                          onChanged: (text) {
                            // mobileNumber = value;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            focusColor: Colors.greenAccent,
                            // labelStyle: ktext14,

                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                )),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
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
                                  color: Colors.grey,
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
                              color: Colors.grey,
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
                              print(imagebytes.lengthInBytes);

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
                                  color: Colors.grey,
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
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
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

              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 40,
                    width: 140,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_scanBarcode != 'Unknown') {
                          if (images.isNotEmpty) {
                            setState(() {
                              details.add({
                                "ShipperId": widget
                                    .customerDetailList[widget.index].shipperId,
                                "ItemDescription": "item",
                                "Barcode": _scanBarcode == "Unknown"
                                    ? ''
                                    : "${_scanBarcode}",
                                "BranchId": widget.loginList.first.bId,
                                "DriverId": widget.loginList.first.dId,
                                "ProductName": "item",
                                "ShipperName":
                                    "${widget.customerDetailList[widget.index].name}",
                                "ShipperMobile":
                                    "${widget.customerDetailList[widget.index].mobile}",
                                "AmountRecieved": amountController.text,
                                "ImageString": "${imageString}",
                                "Status": 'Picked',
                                "RecieverName": "${firstNameController.text}",
                                "RecieverLastName":
                                    "${lastNameController.text}",
                                "RecieverAddress1":
                                    "${address1Controller.text}",
                                "RecieverAddress2":
                                    "${address2Controller.text}",
                                "RecieverCity": "${cityController.text}",
                                "RecieveZip": "${zipCodeController.text}",
                                "RecieverCondactDeatils":
                                    "${contactController.text}",
                                "CODAmount": yescheck != true
                                    ? 0
                                    : amountController.text,
                                "IsCOD": yescheck.toString(),
                                "IsDelete": false.toString(),
                                "LoggedUser": widget.loginList.first.name,
                                "Date": '22',
                              });
                            });
                            firstNameController.clear();
                            lastNameController.clear();
                            address1Controller.clear();
                            address2Controller.clear();
                            cityController.clear();
                            zipCodeController.clear();
                            contactController.clear();
                            _scanBarcode = 'Unknown';
                            images = [];
                            amountController.clear();
                          } else {
                            Fluttertoast.showToast(
                                msg: "Please select image",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        } else {
                          Fluttertoast.showToast(
                              msg: "Please Scan Barcode",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: HexColor('17aeb4'),
                      ),
                      child: Text(
                        'Save',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   // ignore: prefer_const_literals_to_create_immutables
              //   children: [
              //     Expanded(
              //       child: Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: Divider(
              //           thickness: 1,
              //           color: Colors.black,
              //         ),
              //       ),
              //     ),
              //     Text(
              //       "Consignment Details",
              //       style: TextStyle(
              //         color: Colors.black,
              //         fontSize: 20,
              //         fontWeight: FontWeight.normal,
              //       ),
              //     ),
              //     Expanded(
              //       child: Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: Divider(
              //           thickness: 1,
              //           color: Colors.black,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // Row(
              //   children: [
              //     SizedBox(
              //       width: 200,
              //       child: Padding(
              //         padding: const EdgeInsets.all(5.0),
              //         child: Center(
              //           child: Text(
              //             "What are you sending?",
              //             style: TextStyle(
              //               fontSize: 14,
              //               fontWeight: FontWeight.w500,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //     Expanded(
              //       child: Padding(
              //         padding: const EdgeInsets.all(5.0),
              //         child: TextFormField(
              //           // validator: phoneValidator,
              //           keyboardType: TextInputType.text,
              //           cursorColor: Colors.green,
              //           controller: itemController,
              //           onChanged: (text) {
              //             // mobileNumber = value;
              //           },
              //           decoration: InputDecoration(
              //             contentPadding: EdgeInsets.all(10),
              //             focusColor: Colors.greenAccent,
              //             // labelStyle: ktext14,
              //
              //             focusedBorder: OutlineInputBorder(
              //                 borderRadius:
              //                     BorderRadius.all(Radius.circular(10.0)),
              //                 borderSide: BorderSide(
              //                   color: Colors.black,
              //                 )),
              //             border: OutlineInputBorder(
              //               borderRadius:
              //                   BorderRadius.all(Radius.circular(10.0)),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // Row(
              //   children: [
              //     SizedBox(
              //       width: 200,
              //       child: Padding(
              //         padding: const EdgeInsets.all(5.0),
              //         child: Center(
              //           child: Text(
              //             "Is this Consignment COD?",
              //             style: TextStyle(
              //               fontSize: 14,
              //               fontWeight: FontWeight.w500,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //     Expanded(
              //       child: Padding(
              //           padding: const EdgeInsets.all(5.0),
              //           child: Row(
              //             children: [
              //               Row(
              //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                 children: [
              //                   Checkbox(
              //                     value: yescheck,
              //                     onChanged: (bool? newvalue) {
              //                       setState(() {
              //                         yescheck = true;
              //                         if (yescheck == true) {
              //                           nocheck = false;
              //                         }
              //                       });
              //                     },
              //                   ),
              //                   Text(
              //                     "Yes",
              //                     style: TextStyle(
              //                       fontSize: 14,
              //                       fontWeight: FontWeight.w500,
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //               Row(
              //                 children: [
              //                   Checkbox(
              //                     value: nocheck,
              //                     onChanged: (bool? newvalue) {
              //                       setState(() {
              //                         nocheck = true;
              //                         if (nocheck == true) {
              //                           yescheck = false;
              //                         }
              //                       });
              //                     },
              //                   ),
              //                   Text(
              //                     "No",
              //                     style: TextStyle(
              //                       fontSize: 14,
              //                       fontWeight: FontWeight.w500,
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ],
              //           )),
              //     ),
              //   ],
              // ),
              // if (yescheck == true)
              //   Row(
              //     children: [
              //       SizedBox(
              //         width: 200,
              //         child: Padding(
              //           padding: const EdgeInsets.all(5.0),
              //           child: Center(
              //             child: Text(
              //               "Received Amount",
              //               style: TextStyle(
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.w500,
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //       Expanded(
              //           child: Padding(
              //         padding: const EdgeInsets.all(5.0),
              //         child: TextFormField(
              //           // validator: phoneValidator,
              //           keyboardType: TextInputType.text,
              //           cursorColor: Colors.green,
              //           controller: amountController,
              //           onChanged: (text) {
              //             // mobileNumber = value;
              //           },
              //           decoration: InputDecoration(
              //             contentPadding: EdgeInsets.all(10),
              //             focusColor: Colors.greenAccent,
              //             // labelStyle: ktext14,
              //
              //             focusedBorder: OutlineInputBorder(
              //                 borderRadius:
              //                     BorderRadius.all(Radius.circular(10.0)),
              //                 borderSide: BorderSide(
              //                   color: Colors.black,
              //                 )),
              //             border: OutlineInputBorder(
              //               borderRadius:
              //                   BorderRadius.all(Radius.circular(10.0)),
              //             ),
              //           ),
              //         ),
              //       )),
              //     ],
              //   ),
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
                      setState(() {
                        loading = true;
                      });
                      postShipment();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: HexColor('17aeb4'),
                    ),
                    child: loading == false
                        ? Text(
                            "Book Now",
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
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
