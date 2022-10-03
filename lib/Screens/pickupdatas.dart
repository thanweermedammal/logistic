import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:get/get.dart';
import 'package:logistics/Screens/pickup_details.dart';
import 'package:logistics/components/packages_menucard.dart';
import 'package:logistics/controller/allshipment_controller.dart';
import 'package:logistics/models/login_model.dart';
import 'package:http/http.dart' as http;

class PickupDatas extends StatelessWidget {
  List<Login> loginList = [];
  PickupDatas({Key? key, required this.loginList}) : super(key: key);
  AllShipmentController allShipmentController =
      Get.put(AllShipmentController());
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        // physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: allShipmentController.allshipmentList!.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Container(
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
                  padding:
                      const EdgeInsets.only(top: 20.0, right: 20, left: 20),
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
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
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
                                  '${allShipmentController.allshipmentList![index].shipmentId.toString()}',
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
                        padding: const EdgeInsets.only(top: 15.0, left: 15.0),
                        child: Text(
                          'Address',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 15),
                        child: Text(
                          '${allShipmentController.customerDetailslist!.first.address}\n${allShipmentController.customerDetailslist!.first.city}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
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
                                left: 10, right: 10, top: 10),
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
                                      'http://185.188.127.100/WaselleApi/api/PickUp/IgnorePickUpRequest?DriverId=${loginList.first.dId}&BranchId=${loginList.first.bId}&PickupRequestId=${allShipmentController.allshipmentList![index].pickUpRequestId}'));
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
                                      'http://185.188.127.100/WaselleApi/api/PickUp/AcceptPickUpRequest?DriverId=${loginList.first.dId}&BranchId=${loginList.first.bId}&PickupRequestId=${allShipmentController.allshipmentList![index].pickUpRequestId}'));
                                  if (response.statusCode == 200) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => PickDetails(
                                                custname: allShipmentController
                                                    .customerDetailslist!
                                                    .first
                                                    .name,
                                                pickaddress:
                                                    allShipmentController
                                                        .customerDetailslist!
                                                        .first
                                                        .address,
                                                shipid: allShipmentController
                                                    .allshipmentList![index]
                                                    .shipmentId,
                                                loginList: loginList,
                                                index: index)));
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
                )),
          );
        });
  }
}
