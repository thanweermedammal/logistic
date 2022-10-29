import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:logistics/Screens/deliveydatas_screen.dart';
import 'package:logistics/models/deliverydetail_model.dart';
import 'package:logistics/models/login_model.dart';
import 'package:http/http.dart' as http;

class DeliveryVerify extends StatelessWidget {
  List<DeliveryDetails> deliveryDetailsList = [];
  List<Login> loginList = [];
  final runsheet;
  DeliveryVerify(
      {Key? key, required this.deliveryDetailsList, required this.loginList,required this.runsheet})
      : super(key: key);

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
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: deliveryDetailsList.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                    height: 270,
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
                                    .toString()),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, bottom: 10),
                            child: Text(
                              deliveryDetailsList[index]
                                  .consigneeName
                                  .toString(),
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
                        ],
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          height: 57,
          width: 195,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(15),
          ),
          child: ElevatedButton(
            onPressed: () async {
              List datas = [];
              for (var i = 0; i < deliveryDetailsList.length; i++) {
                datas.add(
                  {
                    "RequestId": deliveryDetailsList[i].barcode,
                    "BranchId": deliveryDetailsList[i].branchId,
                  },
                );
              }
              String jsonData;
              jsonData = json.encode(datas);
              var response = await http.post(
                  Uri.parse(
                      'http://185.188.127.100/WaselleApi/api/RunSheet/ConfirmedByDriver'),
                  headers: {
                    "Accept": "application/json",
                    "content-type": "application/json"
                  },
                  body: jsonData);

              if (response.statusCode == 200) {
                print(response.body);
                final snackBar = SnackBar(
                    content: Text('Successfully verified ${response.body}'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                if (response.body != 0) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DeliveryDatasScreen(

                                loginList: loginList, runsheet: runsheet,
                              )));
                }
              }
            },
            style: ElevatedButton.styleFrom(
              primary: HexColor('28759A'),
            ),
            child: Text(
              "Verify",
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
