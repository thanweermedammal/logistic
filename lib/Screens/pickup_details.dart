// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:get/get.dart';
import 'package:logistics/Screens/map_deliveryboy.dart';
import 'package:logistics/controller/allshipment_controller.dart';
import 'package:logistics/models/customerdetails.dart';
import 'package:logistics/models/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class PickDetails extends StatefulWidget {
  final custname;
  final shipid;
  final pickaddress;
  int index;
  List<Login> loginList = [];

  PickDetails({
    Key? key,
    required this.custname,
    required this.pickaddress,
    required this.shipid,
    required this.loginList,
    required this.index,
  }) : super(key: key);

  @override
  State<PickDetails> createState() => _PickDetailsState();
}

class _PickDetailsState extends State<PickDetails> {
  AllShipmentController allShipmentController =
      Get.put(AllShipmentController());
  final now = DateTime.now();

  // List<CustomerDetails> customerDetailslist = [];
  // customdetails() async {
  //   var response = await http.get(Uri.parse(
  //       'http://185.188.127.100/WaselleApi/api/Shipper/GetAllShipperSearchById?ShipperId=1&BranchId=1'));
  //   final customerData = jsonDecode(response.body);
  //   if (response.statusCode == 200) {
  //     print('ijb');
  //     setState(() {
  //       customerDetailslist = List<CustomerDetails>.from(
  //           customerData.map((x) => CustomerDetails.fromJson(x)));
  //     });
  //     return customerDetailslist;
  //   } else {
  //     print('errrr');
  //   }
  // }

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
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    Container(
                        height: 370,
                        width: MediaQuery.of(context).size.width,
                        clipBehavior: Clip.antiAlias,
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
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, right: 20, left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Customer Name',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${allShipmentController.customerDetailslist!.first.name}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Divider(
                                color: Colors.grey,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          'Customer ID',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        Text(
                                          '${allShipmentController.customerDetailslist!.first.shipperId}',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          'Shipment ID',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        Text(
                                          '${allShipmentController.allshipmentList![widget.index].shipmentId.toString()}',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          'Branch ID',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        Text(
                                          '${allShipmentController.customerDetailslist!.first.branchId.toString()}',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 15.0, left: 15.0),
                                child: Text(
                                  'Address',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, left: 15),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        '${allShipmentController.customerDetailslist!.first.address}\n${allShipmentController.customerDetailslist!.first.city}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Expanded(
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
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                height: 80,
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                        'COD Amount',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      )),
                                      Text(
                                        "OMR  ${allShipmentController.allshipmentList![widget.index].codAmount}",
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w500,
                                            color: HexColor('28759A')),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 58,
                            width: 58,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue[50]),
                            child: GestureDetector(
                                onTap: () {
                                  final phoneNumber = allShipmentController
                                      .allshipmentList![widget.index].mobile;
                                  launchUrl(Uri.parse("tel: $phoneNumber"));
                                },
                                child:
                                    Image.asset('assets/images/phoneicon.png')),
                          ),
                          Container(
                            height: 58,
                            width: 58,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.green[50]),
                            child:
                                Image.asset('assets/images/WhatsappLogo.png'),
                          ),
                          GestureDetector(
                            onTap: () async {
                              var response = await http.get(Uri.parse(
                                  'http://185.188.127.100/WaselleApi/api/CancelShipment?ShipmentId2=${allShipmentController.allshipmentList![widget.index].shipmentId}&BranchId=${widget.loginList.first.bId}'));
                            },
                            child: Container(
                              height: 58,
                              width: 58,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.red[50]),
                              child: Image.asset('assets/images/Prohibit.png'),
                            ),
                          ),
                        ],
                      ),
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
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MapDelivery(
                                  custname: allShipmentController
                                      .customerDetailslist!.first.name,
                                  shipid: widget.shipid,
                                  pickaddress: widget.pickaddress,
                                  loginList: widget.loginList,
                                  index: widget.index,
                                ),
                              ),
                            );
                          },
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

                //             Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Expanded(
                //                   child: Row(
                //                     // ignore: prefer_const_literals_to_create_immutables
                //                     children: [
                //                       Text(
                //                         "Customer name: ",
                //                         style: TextStyle(
                //                           fontSize: 16,
                //                           fontWeight: FontWeight.normal,
                //                           color: Colors.black,
                //                         ),
                //                       ),
                //                       Text(
                //                         // allShipmentController
                //                         //     .customerDetailslist!.first.name
                //                         //     .toString(),
                //                         '',
                //                         style: TextStyle(
                //                           fontSize: 14,
                //                           fontWeight: FontWeight.normal,
                //                           color: Colors.black,
                //                         ),
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //                 Expanded(
                //                   child: Row(
                //                     // ignore: prefer_const_literals_to_create_immutables
                //                     children: [
                //                       Text(
                //                         "Shipment ID : ",
                //                         style: TextStyle(
                //                           fontSize: 16,
                //                           fontWeight: FontWeight.normal,
                //                           color: Colors.black,
                //                         ),
                //                       ),
                //                       Text(
                //                         widget.shipid.toString(),
                //                         style: TextStyle(
                //                           fontSize: 14,
                //                           fontWeight: FontWeight.normal,
                //                           color: Colors.black,
                //                         ),
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //     SizedBox(
                //       height: 10,
                //     ),
                //     Container(
                //       clipBehavior: Clip.antiAlias,
                //       decoration: BoxDecoration(
                //         border: Border.all(),
                //         borderRadius: BorderRadius.circular(5),
                //       ),
                //       child: Padding(
                //         padding: const EdgeInsets.all(15.0),
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           mainAxisAlignment: MainAxisAlignment.start,
                //           children: [
                //             Text(
                //               "Pick Up Details",
                //               style: TextStyle(
                //                 fontSize: 18,
                //                 fontWeight: FontWeight.bold,
                //                 color: Colors.black,
                //               ),
                //             ),
                //             SizedBox(
                //               height: 10,
                //             ),
                //             Row(
                //               // ignore: prefer_const_literals_to_create_immutables
                //               children: [
                //                 Text(
                //                   "Pick Up Job Number : ",
                //                   style: TextStyle(
                //                     fontSize: 16,
                //                     fontWeight: FontWeight.normal,
                //                     color: Colors.black,
                //                   ),
                //                 ),
                //                 Text(
                //                   "12",
                //                   style: TextStyle(
                //                     fontSize: 16,
                //                     fontWeight: FontWeight.normal,
                //                     color: Colors.black,
                //                   ),
                //                 ),
                //               ],
                //             ),
                //             SizedBox(
                //               height: 10,
                //             ),
                //             Row(
                //               // ignore: prefer_const_literals_to_create_immutables
                //               children: [
                //                 Text(
                //                   "Company Name : ",
                //                   style: TextStyle(
                //                     fontSize: 16,
                //                     fontWeight: FontWeight.normal,
                //                     color: Colors.black,
                //                   ),
                //                 ),
                //                 Text(
                //                   "Seek Pvt Ltd",
                //                   style: TextStyle(
                //                     fontSize: 16,
                //                     fontWeight: FontWeight.normal,
                //                     color: Colors.black,
                //                   ),
                //                 ),
                //               ],
                //             ),
                //             SizedBox(
                //               height: 10,
                //             ),
                //             Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               // ignore: prefer_const_literals_to_create_immutables
                //               children: [
                //                 Row(
                //                   children: [
                //                     Icon(
                //                       Icons.location_on,
                //                     ),
                //                     Text(
                //                       widget.pickaddress,
                //                       style: TextStyle(
                //                         fontSize: 16,
                //                         fontWeight: FontWeight.normal,
                //                         color: Colors.black,
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //                 Text(
                //                   "2.2Km",
                //                   style: TextStyle(
                //                     fontSize: 16,
                //                     fontWeight: FontWeight.normal,
                //                     color: Colors.black,
                //                   ),
                //                 ),
                //               ],
                //             ),
                //             SizedBox(
                //               height: 10,
                //             ),
                //             Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 Column(
                //                   children: [
                //                     SizedBox(
                //                       height: 60,
                //                       width: 150,
                //                       child: Padding(
                //                         padding: const EdgeInsets.all(8.0),
                //                         child: Image.asset(
                //                           "assets/images/barcode.png",
                //                           fit: BoxFit.cover,
                //                         ),
                //                       ),
                //                     ),
                //                     Text(
                //                       "87 896 5669 4663",
                //                       style: TextStyle(
                //                         fontSize: 16,
                //                         fontWeight: FontWeight.normal,
                //                         color: Colors.black,
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //               ],
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //     SizedBox(
                //       height: 10,
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.symmetric(horizontal: 20),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Column(
                //             children: [
                //               Container(
                //                 decoration: BoxDecoration(
                //                   border: Border.all(width: 1.5),
                //                   borderRadius: BorderRadius.circular(5),
                //                 ),
                //                 child: Padding(
                //                   padding: const EdgeInsets.all(8.0),
                //                   child: Image.asset(
                //                     "assets/images/call.png",
                //                     height: 40,
                //                     width: 40,
                //                     fit: BoxFit.cover,
                //                   ),
                //                 ),
                //               ),
                //               SizedBox(
                //                 height: 10,
                //               ),
                //               Text(
                //                 "Call",
                //                 style: TextStyle(
                //                   fontSize: 12,
                //                   fontWeight: FontWeight.normal,
                //                   color: Colors.black,
                //                 ),
                //               ),
                //             ],
                //           ),
                //           Column(
                //             children: [
                //               GestureDetector(
                //                 onTap: () {
                //                   Navigator.push(
                //                     context,
                //                     MaterialPageRoute(
                //                       builder: (context) => MapDelivery(
                //                         custname: widget.custname,
                //                         shipid: widget.shipid,
                //                         pickaddress: widget.pickaddress,
                //                         loginList: widget.loginList,
                //                         index: widget.index,
                //                       ),
                //                     ),
                //                   );
                //                 },
                //                 child: Container(
                //                   decoration: BoxDecoration(
                //                     border: Border.all(width: 1.5),
                //                     borderRadius: BorderRadius.circular(5),
                //                   ),
                //                   child: Padding(
                //                     padding: const EdgeInsets.all(8.0),
                //                     child: Image.asset(
                //                       "assets/images/navigate.png",
                //                       height: 40,
                //                       width: 40,
                //                       fit: BoxFit.cover,
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //               SizedBox(
                //                 height: 10,
                //               ),
                //               Text(
                //                 "Navigate",
                //                 style: TextStyle(
                //                   fontSize: 12,
                //                   fontWeight: FontWeight.normal,
                //                   color: Colors.black,
                //                 ),
                //               ),
                //             ],
                //           ),
                //           Column(
                //             children: [
                //               Container(
                //                 decoration: BoxDecoration(
                //                   border: Border.all(width: 1.5),
                //                   borderRadius: BorderRadius.circular(5),
                //                 ),
                //                 child: Padding(
                //                   padding: const EdgeInsets.all(8.0),
                //                   child: Image.asset(
                //                     "assets/images/message.png",
                //                     height: 40,
                //                     width: 40,
                //                     fit: BoxFit.cover,
                //                   ),
                //                 ),
                //               ),
                //               SizedBox(
                //                 height: 10,
                //               ),
                //               Text(
                //                 "Message",
                //                 style: TextStyle(
                //                   fontSize: 12,
                //                   fontWeight: FontWeight.normal,
                //                   color: Colors.black,
                //                 ),
                //               ),
                //             ],
                //           ),
                //           Column(
                //             children: [
                //               Container(
                //                 decoration: BoxDecoration(
                //                   border: Border.all(width: 1.5),
                //                   borderRadius: BorderRadius.circular(5),
                //                 ),
                //                 child: Padding(
                //                   padding: const EdgeInsets.all(8.0),
                //                   child: Image.asset(
                //                     "assets/images/cancelled.png",
                //                     height: 40,
                //                     width: 40,
                //                     fit: BoxFit.cover,
                //                   ),
                //                 ),
                //               ),
                //               SizedBox(
                //                 height: 10,
                //               ),
                //               Text(
                //                 "Cancel",
                //                 style: TextStyle(
                //                   fontSize: 12,
                //                   fontWeight: FontWeight.normal,
                //                   color: Colors.black,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ],
                //       ),
                //     ),
                //     SizedBox(
                //       height: 20,
                //     ),
                //     Center(
                //       child: Container(
                //         height: 50,
                //         width: 200,
                //         clipBehavior: Clip.antiAlias,
                //         decoration: BoxDecoration(
                //           color: Colors.transparent,
                //           borderRadius: BorderRadius.circular(5),
                //         ),
                //         child: ElevatedButton(
                //           onPressed: () {},
                //           style: ElevatedButton.styleFrom(
                //             primary: HexColor('17aeb4'),
                //           ),
                //           child: Text(
                //             "Go To Pickup",
                //             style: TextStyle(
                //               fontSize: 15,
                //               color: Color(0xffffffff),
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //     SizedBox(
                //       height: 40,
                //     ),
                //   ],
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
