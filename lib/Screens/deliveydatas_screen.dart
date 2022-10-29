import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:logistics/Screens/deliveredpersondetail_screen.dart';
import 'package:logistics/Screens/home_screen.dart';
import 'package:logistics/models/deliverydetail_model.dart';
import 'package:logistics/models/login_model.dart';
import 'package:http/http.dart' as http;

class DeliveryDatasScreen extends StatefulWidget {
  // List<DeliveryDetails> deliveryDetailsList = [];
  List<Login> loginList = [];
  final runsheet;
  DeliveryDatasScreen(
      {Key? key, required this.loginList, required this.runsheet})
      : super(key: key);

  @override
  State<DeliveryDatasScreen> createState() => _DeliveryDatasScreenState();
}

class _DeliveryDatasScreenState extends State<DeliveryDatasScreen> {
  List<DeliveryDetails> deliveryDetailsList = [];
  GetData() async {
    var response = await http.get(Uri.parse(
        'http://185.188.127.100/WaselleApi/api/Shipment/GetRunsheetDetails?DriverId=${widget.loginList.first.dId}&BranchId=${widget.loginList.first.bId}&RunsheetId=${widget.runsheet}'));
    final deliveryData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print('ok');

      setState(() {
        deliveryDetailsList = List<DeliveryDetails>.from(
            deliveryData.map((x) => DeliveryDetails.fromJson(x)));
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    GetData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                      onTap: (() => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  HomeScreen(widget.loginList)),
                          (route) => false)),
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
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: deliveryDetailsList.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                    height: 340,
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
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Consumer Name',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(deliveryDetailsList[index]
                                    .barcode
                                    .toString())
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, bottom: 10),
                            child: Text(
                              deliveryDetailsList[index].branchName.toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Address',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, bottom: 10),
                            child: Text(
                              deliveryDetailsList[index].toAddress.toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Text('Branch ID',
                                        style: TextStyle(color: Colors.grey)),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        deliveryDetailsList[index]
                                            .branchId
                                            .toString(),
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    Text('Shipment ID',
                                        style: TextStyle(color: Colors.grey)),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        deliveryDetailsList[index]
                                            .shipmentId
                                            .toString(),
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 32,
                                    width: 67,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 1,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(deliveryDetailsList[index]
                                                  .amountRecieved ==
                                              0.0
                                          ? "COD"
                                          : "Paid"),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    height: 42,
                                    width: 67,
                                    decoration: BoxDecoration(
                                        color: HexColor('17B5BC')),
                                    child: Center(
                                      child: Text(
                                        deliveryDetailsList[index]
                                            .codAmount
                                            .toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 100, vertical: 10),
                            child: Container(
                              height: 35,
                              width: 132,
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
                                          builder: (context) =>
                                              DeliveredPersonDetail(
                                                deliveryDetailsList:
                                                    deliveryDetailsList,
                                                index: index,
                                                loginList: widget.loginList,
                                                runsheet: widget.runsheet,
                                              )));
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: HexColor('28759A'),
                                ),
                                child: Text(
                                  "Proceed",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
