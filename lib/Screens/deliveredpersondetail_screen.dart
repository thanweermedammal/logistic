import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:logistics/Screens/deliveydatas_screen.dart';
import 'package:logistics/Screens/maplocation_screen.dart';
import 'package:logistics/Screens/maptext.dart';
import 'package:logistics/models/deliverydetail_model.dart';
import 'package:logistics/models/login_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class DeliveredPersonDetail extends StatefulWidget {
  List<DeliveryDetails> deliveryDetailsList = [];
  int index;
  List<Login> loginList = [];
  final runsheet;
  DeliveredPersonDetail(
      {Key? key,
      required this.deliveryDetailsList,
      required this.index,
      required this.loginList,
      required this.runsheet})
      : super(key: key);

  @override
  State<DeliveredPersonDetail> createState() => _DeliveredPersonDetailState();
}

class _DeliveredPersonDetailState extends State<DeliveredPersonDetail> {
  bool show = false;
  final now = DateTime.now();
  TextEditingController timeReceivedController = TextEditingController();
  TextEditingController reasonController = TextEditingController();

  Cancel({@required context, @required status, @required statusHeader}) async {
    var response = await http.post(
        Uri.parse(
            'http://185.188.127.100/WaselleApi/api/Driver/SaveDeliveryCancel'),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonEncode([
          {
            "ShipmentId": widget.deliveryDetailsList[widget.index].shipmentId,
            "BranchId": widget.loginList.first.bId,
            "DriverId": widget.loginList.first.dId,
            "Barcode": widget.deliveryDetailsList[widget.index].barcode,
            "RunSheetId": widget.deliveryDetailsList[widget.index].runsheetId,
            "RunSheetDetailId":
                widget.deliveryDetailsList[widget.index].runSheetDetailId,
            "StatusHeader": statusHeader,
            "Status": status
          }
        ]));
    if (response.statusCode == 200) {
      print(response.body);

      if (response.body != 0) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DeliveryDatasScreen(
                    loginList: widget.loginList, runsheet: widget.runsheet)));
      }
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // height: MediaQuery.of(context).size.height,
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
                          height: 173,
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
                                  ],
                                ),
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
                        padding: const EdgeInsets.only(
                          top: 130,
                        ),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            Image.asset(
                                              'assets/images/Rectangle 24.png',
                                              width: 250,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8.0,
                                              ),
                                              child: Text(
                                                widget
                                                    .deliveryDetailsList[
                                                        widget.index]
                                                    .barcode
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 24,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'Branch Id',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.grey),
                                                ),
                                              ),
                                              Expanded(
                                                  child: Text(widget
                                                      .deliveryDetailsList[
                                                          widget.index]
                                                      .branchId
                                                      .toString())),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'Shipment Id',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.grey),
                                                ),
                                              ),
                                              Expanded(
                                                  child: Text(widget
                                                      .deliveryDetailsList[
                                                          widget.index]
                                                      .shipmentId
                                                      .toString())),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'Consumer Name',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.grey),
                                                ),
                                              ),
                                              Expanded(
                                                  child: Text(widget
                                                      .deliveryDetailsList[
                                                          widget.index]
                                                      .consigneeName
                                                      .toString())),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'Delivery Address',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.grey),
                                                ),
                                              ),
                                              Expanded(
                                                  child: Text(widget
                                                      .deliveryDetailsList[
                                                          widget.index]
                                                      .toAddress
                                                      .toString())),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'Payment Type',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.grey),
                                                ),
                                              ),
                                              Expanded(
                                                  child: Text(widget
                                                              .deliveryDetailsList[
                                                                  widget.index]
                                                              .codAmount !=
                                                          0.0
                                                      ? "COD"
                                                      : "Paid")),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'Amount',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.grey),
                                                ),
                                              ),
                                              Expanded(
                                                // flex: 2,
                                                child: Container(
                                                  height: 42,
                                                  width: 67,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          HexColor('17B5BC')),
                                                  child: Center(
                                                    child: Text(
                                                      widget
                                                          .deliveryDetailsList[
                                                              widget.index]
                                                          .codAmount
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        // Padding(
                                        //   padding: const EdgeInsets.all(8.0),
                                        //   child: Row(
                                        //     children: [
                                        //       Expanded(
                                        //         child: Text(
                                        //           'Delivery Charge',
                                        //           style: TextStyle(
                                        //               fontSize: 15,
                                        //               color: Colors.grey),
                                        //         ),
                                        //       ),
                                        //       Expanded(
                                        //         // flex: 2,
                                        //         child: Container(
                                        //           height: 42,
                                        //           width: 67,
                                        //           decoration: BoxDecoration(
                                        //               color:
                                        //                   HexColor('17B5BC')),
                                        //           child: Center(
                                        //             child: Text(
                                        //               deliveryDetailsList[index]
                                        //                   .shippingCharge
                                        //                   .toString(),
                                        //               style: TextStyle(
                                        //                   color: Colors.white),
                                        //             ),
                                        //           ),
                                        //         ),
                                        //       )
                                        //     ],
                                        //   ),
                                        // ),
                                        Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: 58,
                                                width: 58,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.blue[50]),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    final phoneNumber = widget
                                                        .deliveryDetailsList[
                                                            widget.index]
                                                        .consigneeMobile;
                                                    launchUrl(Uri.parse(
                                                        "tel: $phoneNumber"));
                                                  },
                                                  child: Image.asset(
                                                      'assets/images/phoneicon.png'),
                                                ),
                                              ),
                                              Container(
                                                height: 58,
                                                width: 58,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.green[50]),
                                                child: Image.asset(
                                                    'assets/images/WhatsappLogo.png'),
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          content: Stack(
                                                            children: <Widget>[
                                                              Positioned(
                                                                right: -40.0,
                                                                top: -40.0,
                                                                child:
                                                                    InkResponse(
                                                                  onTap: () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child:
                                                                      CircleAvatar(
                                                                    child: Icon(
                                                                        Icons
                                                                            .close),
                                                                    backgroundColor:
                                                                        Colors
                                                                            .red,
                                                                  ),
                                                                ),
                                                              ),
                                                              Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: <
                                                                    Widget>[
                                                                  Center(
                                                                    child: Padding(
                                                                        padding: EdgeInsets.all(8.0),
                                                                        child: GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            CancelReason('general');
                                                                          },
                                                                          child:
                                                                              Text('General'),
                                                                        )),
                                                                  ),
                                                                  Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          CancelReason(
                                                                              'hold');
                                                                        },
                                                                        child: Text(
                                                                            'Hold'),
                                                                      )),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        CancelReason(
                                                                            'undelivered');
                                                                      },
                                                                      child: Text(
                                                                          'UnDelivered'),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      });
                                                },
                                                child: Container(
                                                  height: 58,
                                                  width: 58,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.red[50]),
                                                  child: Image.asset(
                                                      'assets/images/Prohibit.png'),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 51,
                                      width: 218,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => MapText(
                                                        deliveryDetailsList: widget
                                                            .deliveryDetailsList,
                                                        index: widget.index,
                                                        loginList:
                                                            widget.loginList,
                                                        runsheet:
                                                            widget.runsheet,
                                                      )));
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: HexColor('17aeb4'),
                                        ),
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: Row(
                                            children: [
                                              Transform.rotate(
                                                angle: 5.5,
                                                child: Icon(
                                                  Icons.navigation_outlined,
                                                  size: 25,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 3,
                                              ),
                                              Text(
                                                "Proceed To Navigate",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xffffffff),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
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
          ],
        ),
      ),
    );
  }

  CancelReason(status) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Stack(
              children: <Widget>[
                Positioned(
                  right: -40.0,
                  top: -40.0,
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CircleAvatar(
                      child: Icon(Icons.close),
                      backgroundColor: Colors.red,
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        maxLines: 2,
                        // validator: phoneValidator,
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.green,
                        controller: reasonController,
                        onChanged: (text) {
                          // mobileNumber = value;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          focusColor: Colors.greenAccent,
                          // labelStyle: ktext14,
                          labelText: "Reason",
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
                    SizedBox(
                      height: 10,
                    ),
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
                          Cancel(
                              context: context,
                              status: status,
                              statusHeader: reasonController.text);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: HexColor('17aeb4'),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xffffffff),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
