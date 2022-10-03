import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:get/get.dart';
import 'package:logistics/Screens/add_consignment.dart';
import 'package:logistics/components/delivery_card.dart';
import 'package:logistics/controller/allshipment_controller.dart';
import 'package:logistics/models/customerdetails.dart';
import 'package:logistics/models/delivery_model.dart';
import 'package:http/http.dart' as http;
import 'package:logistics/models/login_model.dart';

class SearchById extends StatefulWidget {
  List<Login> loginList = [];
  SearchById({required this.loginList});
  @override
  State<SearchById> createState() => _SearchByIdState();
}

class _SearchByIdState extends State<SearchById> {
  AllShipmentController allShipmentController =
      Get.put(AllShipmentController());
  List<CustomerDetails> customerDetailList = [];
  TextEditingController shipmentIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Add Consignment",
                style: TextStyle(
                  color: HexColor('2a7799'),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      // validator: phoneValidator,
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.green,
                      controller: shipmentIdController,
                      onChanged: (text) {
                        // mobileNumber = value;
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        focusColor: Colors.greenAccent,
                        // labelStyle: ktext14,
                        labelText: "Shipper ID",
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
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      height: 40,
                      width: 120,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          var response = await http.get(Uri.parse(
                              'http://185.188.127.100/WaselleApi/api/Shipper/GetAllShipperSearchById?ShipperId=${shipmentIdController.text}&BranchId=${widget.loginList.first.bId}'));
                          final customerData = jsonDecode(response.body);
                          if (response.statusCode == 200) {
                            print('ok');

                            setState(() {
                              customerDetailList = List<CustomerDetails>.from(
                                  customerData
                                      .map((x) => CustomerDetails.fromJson(x)));
                            });
                          } else {
                            print('errrr');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: HexColor('17aeb4'),
                        ),
                        child: Text(
                          "Search",
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
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: customerDetailList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddConsignment(
                                  loginList: widget.loginList,
                                  customerDetailList: customerDetailList,
                                  index: index,
                                )));
                  },
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(1, 1),
                                blurRadius: 3,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Text(
                                        '${customerDetailList[index].name.toString()}')),
                                Expanded(
                                    child: Text(
                                        'Shipper ID : ${customerDetailList[index].shipperId.toString()}')),
                              ],
                            ),
                          ))),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
