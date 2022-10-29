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
        body: Column(
          children: [
            SizedBox(
              height: 40,
            ),
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
            PickupDatas(
              loginList: widget.loginList,
            ),
          ],
        ));
  }
}
