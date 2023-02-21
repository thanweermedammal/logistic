import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
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
  bool loading = false;
  AllShipmentController allShipmentController =
      Get.put(AllShipmentController());
  List<CustomerDetails> customerDetailList = [];
  TextEditingController mobileController = TextEditingController();

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
                      controller: mobileController,
                      onChanged: (text) {
                        // mobileNumber = value;
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        focusColor: Colors.greenAccent,
                        // labelStyle: ktext14,
                        labelText: "Shipper Id / Mobile Number",
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
                          setState(() {
                            loading = true;
                          });
                          if (mobileController.text.length > 6) {
                            var response = await http.get(Uri.parse(
                                'http://185.188.127.100/WaselleApi/api/Shipper/GetShipperDetailsBySearch?BranchId=${widget.loginList.first.bId}&Mobile=${mobileController.text}'));
                            final customerData = jsonDecode(response.body);
                            if (response.statusCode == 200) {
                              print('ok');

                              setState(() {
                                loading = false;
                                customerDetailList = List<CustomerDetails>.from(
                                    customerData.map(
                                        (x) => CustomerDetails.fromJson(x)));
                              });
                            } else {
                              print('errrr');
                              setState(() {
                                loading = false;
                              });
                            }
                          } else {
                            var response = await http.get(Uri.parse(
                                'http://185.188.127.100/WaselleApi/api/Shipper/GetAllShipperSearchById?ShipperId=${mobileController.text}&BranchId=${widget.loginList.first.bId}'));
                            final customerData = jsonDecode(response.body);
                            if (response.statusCode == 200) {
                              print('ok');

                              setState(() {
                                loading = false;
                                customerDetailList = List<CustomerDetails>.from(
                                    customerData.map(
                                        (x) => CustomerDetails.fromJson(x)));
                              });
                            } else {
                              print('errrr');
                              setState(() {
                                loading = false;
                              });
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: HexColor('17aeb4'),
                        ),
                        child: loading == false
                            ? Text(
                                "Search",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
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
                return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Container(
                        // height: 50,
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Shipper ID",
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          height: 38,
                                          width: double.infinity,
                                          color: Colors.grey.shade200,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                '${customerDetailList[index].shipperId.toString()}'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Branch ID",
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          height: 38,
                                          width: double.infinity,
                                          color: Colors.grey.shade200,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                '${customerDetailList[index].branchId.toString()}'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Shipper Name",
                                style: TextStyle(color: Colors.grey),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                height: 38,
                                width: double.infinity,
                                color: Colors.grey.shade200,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      '${customerDetailList[index].name.toString()}'),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Phone Number",
                                style: TextStyle(color: Colors.grey),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                height: 38,
                                width: double.infinity,
                                color: Colors.grey.shade200,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      '${customerDetailList[index].phoneNumber.toString()}'),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Address",
                                style: TextStyle(color: Colors.grey),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                height: 90,
                                width: double.infinity,
                                color: Colors.grey.shade200,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      '${customerDetailList[index].address.toString()}'),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddConsignment(
                                                    loginList: widget.loginList,
                                                    customerDetailList:
                                                        customerDetailList,
                                                    index: index,
                                                  )));
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 120,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        color: HexColor('17aeb4'),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Center(
                                        child: Text("Select",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xffffffff),
                                            )),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )));
              },
            ),
          ],
        ),
      ),
    );
  }
}
