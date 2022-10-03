// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:get/get.dart';
import 'package:logistics/Screens/packages_menu.dart';
import 'package:logistics/Screens/pickupdatas.dart';
import 'package:logistics/components/packages_menucard.dart';
import 'package:logistics/components/pickup_card.dart';
import 'package:logistics/controller/allshipment_controller.dart';
import 'package:logistics/models/login_model.dart';
import 'package:logistics/models/pickup_model.dart';

class PickUpRequest extends StatefulWidget {
  List<Login> loginList = [];
  PickUpRequest({Key? key, required this.loginList});

  @override
  State<PickUpRequest> createState() => _PickUpRequestState();
}

class _PickUpRequestState extends State<PickUpRequest>
    with TickerProviderStateMixin {
  AllShipmentController allShipmentController =
      Get.put(AllShipmentController());
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
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
                    child: Text(
                      "Pick Ups",
                      style: TextStyle(
                        color: HexColor('2a7799'),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TabBar(
                    controller: tabController,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: HexColor('16ADB5'),
                    ),
                    // indicatorWeight: 1,
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: [
                      SizedBox(
                        height: 34,
                        child: Center(
                          child: Text(
                            "Requests",
                            style: TextStyle(
                              fontSize: 16,
                              // fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 34,
                        child: Center(
                          child: Text(
                            "Accepted",
                            style: TextStyle(
                              fontSize: 16,
                              // fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 34,
                        child: Center(
                          child: Text(
                            "Cancelled",
                            style: TextStyle(
                              fontSize: 16,
                              // fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(controller: tabController, children: [
        PickupDatas(
          loginList: widget.loginList,
        ),
        PickupDatas(
          loginList: widget.loginList,
        ),
        PickupDatas(
          loginList: widget.loginList,
        ),
      ]),
    );
  }
}
