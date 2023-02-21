import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:logistics/Screens/deliveydatas_screen.dart';
import 'package:logistics/Screens/home_screen.dart';
import 'package:logistics/Screens/maplocation_screen.dart';
import 'package:logistics/Screens/maptext.dart';
import 'package:logistics/models/deliverydetail_model.dart';
import 'package:logistics/models/login_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class VerificationDelivery extends StatefulWidget {
  List<DeliveryDetails> deliveryDetailsList = [];
  int index;
  List<Login> loginList = [];

  final runsheet;
  VerificationDelivery(
      {Key? key,
      required this.deliveryDetailsList,
      required this.index,
      required this.runsheet,
      required this.loginList})
      : super(key: key);

  @override
  State<VerificationDelivery> createState() => _VerificationDeliveryState();
}

class _VerificationDeliveryState extends State<VerificationDelivery> {
  final now = DateTime.now();
  bool loading = false;

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Cash"), value: "Cash"),
      DropdownMenuItem(child: Text("Online"), value: "Online"),
      DropdownMenuItem(child: Text("Card"), value: "Card"),
      DropdownMenuItem(child: Text("Upi"), value: "Upi"),
    ];
    return menuItems;
  }

  String selectedValue = "Cash";
  TextEditingController amountReceivedController = TextEditingController();
  TextEditingController deliveryReceivedController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                                  'Mobile Number',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.grey),
                                                ),
                                              ),
                                              Expanded(
                                                  child: Text(widget
                                                      .deliveryDetailsList[
                                                          widget.index]
                                                      .consigneeMobile
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
                                        // Padding(
                                        //   padding: const EdgeInsets.all(8.0),
                                        //   child: Row(
                                        //     children: [
                                        //       Expanded(
                                        //         child: Text(
                                        //           'price',
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
                                        //               widget
                                        //                   .deliveryDetailsList[
                                        //                       widget.index]
                                        //                   .codAmount
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
                                        //               widget
                                        //                   .deliveryDetailsList[
                                        //                       widget.index]
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
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'Total Amount',
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
                                                      "${widget.deliveryDetailsList[widget.index].codAmount}",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 180),
                                      child: Container(
                                        height: 70,
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.access_time,
                                                  color: Colors.grey,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                    '${now.hour} : ${now.minute}')
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.calendar_today,
                                                  color: Colors.grey,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                    '${now.day}-${now.month}-${now.year}')
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Payment Mode',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: DropdownButton(
                                                value: selectedValue,
                                                items: dropdownItems,
                                                onChanged: (value) {
                                                  setState(() {
                                                    selectedValue =
                                                        value.toString();
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Amount Received',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: TextFormField(
                                                // validator: phoneValidator,
                                                keyboardType:
                                                    TextInputType.text,
                                                cursorColor: Colors.green,
                                                controller:
                                                    amountReceivedController,
                                                onChanged: (text) {
                                                  // mobileNumber = value;
                                                },
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.all(10),
                                                  focusColor:
                                                      Colors.greenAccent,
                                                  // labelStyle: ktext14,

                                                  labelStyle: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12,
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5.0)),
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.black,
                                                          )),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10.0)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.all(8.0),
                                    //   child: Row(
                                    //     children: [
                                    //       Expanded(
                                    //         child: Text(
                                    //           'Delivery Charge Received',
                                    //           style: TextStyle(
                                    //               fontSize: 15,
                                    //               color: Colors.grey),
                                    //         ),
                                    //       ),
                                    //       Expanded(
                                    //         child: Padding(
                                    //           padding:
                                    //               const EdgeInsets.all(5.0),
                                    //           child: TextFormField(
                                    //             // validator: phoneValidator,
                                    //             keyboardType:
                                    //                 TextInputType.text,
                                    //             cursorColor: Colors.green,
                                    //             controller:
                                    //                 deliveryReceivedController,
                                    //             onChanged: (text) {
                                    //               // mobileNumber = value;
                                    //             },
                                    //             decoration: InputDecoration(
                                    //               contentPadding:
                                    //                   EdgeInsets.all(10),
                                    //               focusColor:
                                    //                   Colors.greenAccent,
                                    //               // labelStyle: ktext14,
                                    //
                                    //               labelStyle: TextStyle(
                                    //                 color: Colors.grey,
                                    //                 fontSize: 12,
                                    //               ),
                                    //               focusedBorder:
                                    //                   OutlineInputBorder(
                                    //                       borderRadius:
                                    //                           BorderRadius.all(
                                    //                               Radius
                                    //                                   .circular(
                                    //                                       5.0)),
                                    //                       borderSide:
                                    //                           BorderSide(
                                    //                         color: Colors.black,
                                    //                       )),
                                    //               border: OutlineInputBorder(
                                    //                 borderRadius:
                                    //                     BorderRadius.all(
                                    //                         Radius.circular(
                                    //                             10.0)),
                                    //               ),
                                    //             ),
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                    SizedBox(
                                      height: 30,
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
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          primary: HexColor('17aeb4'),
                                        ),
                                        child: loading == true
                                            ? LoadingIndicator(
                                                indicatorType: Indicator
                                                    .ballSpinFadeLoader,
                                                colors: [Colors.white],
                                              )
                                            : GestureDetector(
                                                onTap: () async {
                                                  setState(() {
                                                    loading = true;
                                                  });
                                                  var response =
                                                      await http.post(Uri.parse(
                                                          'http://185.188.127.100/WaselleApi/api/Shipment/DeliveredByDriver?BranchId=${widget.loginList.first.bId}&ShipmentId=${widget.deliveryDetailsList[widget.index].shipmentId}&Barcode=${widget.deliveryDetailsList[widget.index].barcode}&CODAmount=${amountReceivedController.text}&CollectedShippingCharge=${widget.deliveryDetailsList[widget.index].shippingCharge}'));
                                                  if (response.statusCode ==
                                                      200) {
                                                    print('Sucess');
                                                    print(response.body);
                                                    final snackBar = SnackBar(
                                                        content: Text(
                                                            'Successfully Delivered ${response.body}'));
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(snackBar);
                                                    if (response.body != 0) {
                                                      if (widget
                                                              .deliveryDetailsList
                                                              .length ==
                                                          widget.index + 1) {
                                                        // CircularProgressIndicator();
                                                        Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    HomeScreen(
                                                                        widget
                                                                            .loginList)));
                                                      } else {
                                                        Navigator
                                                            .pushReplacement(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            DeliveryDatasScreen(
                                                                              loginList: widget.loginList,
                                                                              runsheet: widget.runsheet,
                                                                            )));
                                                      }
                                                    }
                                                  } else {
                                                    setState(() {
                                                      loading = false;
                                                    });

                                                    print(response.statusCode);
                                                  }
                                                },
                                                child: Text(
                                                  "Delivered",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xffffffff),
                                                  ),
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
}
