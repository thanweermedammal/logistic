// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:get/get.dart';
import 'package:logistics/controller/allshipment_controller.dart';
import 'package:logistics/controller/sharedvaluehelper.dart';

class TodaysTask extends StatefulWidget {
  var loginList;

  TodaysTask({Key? key, required this.loginList}) : super(key: key);

  @override
  State<TodaysTask> createState() => _TodaysTaskState();
}

class _TodaysTaskState extends State<TodaysTask> with TickerProviderStateMixin {
  AllShipmentController allShipmentController =
      Get.put(AllShipmentController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allShipmentController.fetchAllShipmentData(widget.loginList);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 225,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: HexColor('2a7799'),
                  borderRadius: BorderRadius.circular(15),
                ),
                // ignore: prefer_const_literals_to_create_immutables
                child: Stack(children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      child: Text(
                        "Today's Pickup\nJobs",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Text(
                        allShipmentController.allshipmentList!.length
                            .toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  width: 200,
                  decoration: BoxDecoration(
                    color: HexColor('17b4b7'),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  // ignore: prefer_const_literals_to_create_immutables
                  child: Stack(children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        child: Text(
                          "Assigned Delivery\nJobs",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Text(
                          assigned.$.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
              Container(
                height: 100,
                width: 200,
                decoration: BoxDecoration(
                  color: HexColor('8dd4d6'),
                  borderRadius: BorderRadius.circular(15),
                ),
                // ignore: prefer_const_literals_to_create_immutables
                child: Stack(children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      child: Text(
                        "Today's \nRevenue",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Text(
                        "",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          )
        ],
      ),
    );
  }
}
