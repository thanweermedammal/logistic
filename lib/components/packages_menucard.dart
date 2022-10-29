import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:get/get.dart';
import 'package:logistics/Screens/pickup_details.dart';
import 'package:logistics/controller/allshipment_controller.dart';
import 'package:logistics/models/login_model.dart';
import 'package:logistics/models/packages_model.dart';
import 'package:http/http.dart' as http;

class PackageMenuCard extends StatefulWidget {
  final context;

  final index;

  List<Login> loginList;

  PackageMenuCard({
    Key? key,
    required this.index,
    required this.context,
    required this.loginList,
  }) : super(key: key);

  @override
  State<PackageMenuCard> createState() => _PackageMenuCardState();
}

class _PackageMenuCardState extends State<PackageMenuCard>
    with TickerProviderStateMixin {
  AllShipmentController allShipmentController =
      Get.put(AllShipmentController());
  @override
  void initState() {
    // TODO: implement initState
    allShipmentController.customerData(widget.index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: 280,
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
          padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
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
                  '${allShipmentController.customerDetailslist?.first.name}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
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
                          null !=
                                  allShipmentController
                                      .customerDetailslist?.first.shipperId
                              ? '${allShipmentController.customerDetailslist!.first.shipperId}'
                              : "0",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
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
                              fontSize: 16, fontWeight: FontWeight.w500),
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
                          null !=
                                  allShipmentController
                                      .customerDetailslist?.first.branchId
                              ? '${allShipmentController.customerDetailslist!.first.branchId.toString()}'
                              : "0",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 15.0),
                child: Text(
                  'Address',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 15),
                child: Text(
                  null !=
                          allShipmentController
                              .customerDetailslist?.first.address
                      ? '${allShipmentController.customerDetailslist!.first.address}\n${allShipmentController.customerDetailslist!.first.city}'
                      : '',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                // crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 10),
                    child: Container(
                      height: 33,
                      width: 95,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          var response = await http.get(Uri.parse(
                              'http://185.188.127.100/WaselleApi/api/PickUp/IgnorePickUpRequest?DriverId=${widget.loginList.first.dId}&BranchId=${widget.loginList.first.bId}&PickupRequestId=${allShipmentController.allshipmentList![widget.index].pickUpRequestId}'));
                          if (response.statusCode == 200) {
                            print('Ignored');
                          } else {
                            print(response.statusCode);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                        ),
                        child: Text(
                          "Ignore",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffffffff),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Container(
                      height: 33,
                      width: 95,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          var response = await http.get(Uri.parse(
                              'http://185.188.127.100/WaselleApi/api/PickUp/AcceptPickUpRequest?DriverId=${widget.loginList.first.dId}&BranchId=${widget.loginList.first.bId}&PickupRequestId=${allShipmentController.allshipmentList![widget.index].pickUpRequestId}'));
                          if (response.statusCode == 200) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PickDetails(
                                        custname: allShipmentController
                                            .customerDetailslist!.first.name,
                                        pickaddress: allShipmentController
                                            .customerDetailslist!.first.address,
                                        shipid: allShipmentController
                                            .allshipmentList![widget.index]
                                            .shipmentId,
                                        loginList: widget.loginList,
                                        index: widget.index)));
                          } else {
                            print(response.statusCode);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: HexColor('17aeb4'),
                        ),
                        child: Text(
                          "Accept",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffffffff),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

// Widget packagesmenuCard(
//     {@required index,
//     required BuildContext context,
//     required allshipmentController,
//     required loginList}) {
// return Container(
//     height: 270,
//     width: MediaQuery.of(context).size.width,
//     clipBehavior: Clip.antiAlias,
//     decoration: BoxDecoration(
//       color: Colors.white,
//       shape: BoxShape.rectangle,
//       borderRadius: BorderRadius.circular(20),
//       boxShadow: [
//         BoxShadow(
//           color: Colors.black12,
//           offset: Offset(1, 1),
//           blurRadius: 3,
//         ),
//       ],
//     ),
//     child: Padding(
//       padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Customer Name',
//             style: TextStyle(color: Colors.grey),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               'Rahul',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
//             ),
//           ),
//           Divider(
//             color: Colors.grey,
//           ),
//           Row(
//             children: [
//               Expanded(
//                 child: Column(
//                   children: [
//                     Text(
//                       'Customer ID',
//                       style: TextStyle(color: Colors.grey),
//                     ),
//                     Text(
//                       '1234',
//                       style: TextStyle(
//                           fontSize: 16, fontWeight: FontWeight.w500),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Column(
//                   children: [
//                     Text(
//                       'Shipment ID',
//                       style: TextStyle(color: Colors.grey),
//                     ),
//                     Text(
//                       '${allshipmentController.allshipmentList[index].shipmentId.toString()}',
//                       style: TextStyle(
//                           fontSize: 16, fontWeight: FontWeight.w500),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Column(
//                   children: [
//                     Text(
//                       'Branch ID',
//                       style: TextStyle(color: Colors.grey),
//                     ),
//                     Text(
//                       '${allshipmentController.allshipmentList[index].shipmentId.toString()}',
//                       style: TextStyle(
//                           fontSize: 16, fontWeight: FontWeight.w500),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 15.0, left: 15.0),
//             child: Text(
//               'Address',
//               style: TextStyle(color: Colors.grey),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 8.0, left: 15),
//             child: Text(
//               'Muscat city,\nSulthan of Oman',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Row(
//             // crossAxisAlignment: CrossAxisAlignment.end,
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
//                 child: Container(
//                   height: 33,
//                   width: 85,
//                   clipBehavior: Clip.antiAlias,
//                   decoration: BoxDecoration(
//                     color: Colors.transparent,
//                     borderRadius: BorderRadius.circular(5),
//                   ),
//                   child: ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       primary: Colors.black,
//                     ),
//                     child: Text(
//                       "Ignore",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xffffffff),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 10),
//                 child: Container(
//                   height: 33,
//                   width: 85,
//                   clipBehavior: Clip.antiAlias,
//                   decoration: BoxDecoration(
//                     color: Colors.transparent,
//                     borderRadius: BorderRadius.circular(5),
//                   ),
//                   child: ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       primary: HexColor('17aeb4'),
//                     ),
//                     child: Text(
//                       "Accept",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xffffffff),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     ));
// Container(
//   height: 140,
//   width: MediaQuery.of(context).size.width,
//   clipBehavior: Clip.antiAlias,
//   decoration: const BoxDecoration(
//     color: Colors.white,
//     shape: BoxShape.rectangle,
//     boxShadow: [
//       BoxShadow(
//         color: Colors.black12,
//         offset: Offset(0, -1),
//         blurRadius: 2,
//       ),
//     ],
//   ),
//   child: Row(
//     children: [
//       SizedBox(
//         width: 140,
//         height: MediaQuery.of(context).size.height,
//         child: Image.asset(
//           packagesModel[index].icon,
//           fit: BoxFit.cover,
//         ),
//       ),
//       const SizedBox(
//         width: 10,
//       ),
//       Expanded(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 5),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'Delivery ID:#'
//                 '${allshipmentController.allshipmentList[index].shipmentId.toString()}',
//                 style: const TextStyle(
//                     color: Colors.black,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 '${allshipmentController.allshipmentList[index].itemDescription.toString()}\n${allshipmentController.allshipmentList[index].status.toString()}',
//                 style: const TextStyle(
//                   color: Colors.black,
//                   fontSize: 14,
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Text(
//                       packagesModel[index].detail,
//                       style: const TextStyle(
//                         color: Colors.blue,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       )
//     ],
//   ),
// );
// }
