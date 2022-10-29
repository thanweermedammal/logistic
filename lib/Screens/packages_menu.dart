// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:get/get.dart';
import 'package:logistics/Services/alshipment_service.dart';
import 'package:logistics/components/packages_menucard.dart';
import 'package:logistics/controller/allshipment_controller.dart';
import 'package:logistics/models/customerdetails.dart';
import 'package:logistics/models/login_model.dart';
import 'package:logistics/models/packages_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PackagesMenu extends StatefulWidget {
  List<Login> loginList = [];
  PackagesMenu({Key? key, required this.loginList});

  @override
  State<PackagesMenu> createState() => _PackagesMenuState();
}

class _PackagesMenuState extends State<PackagesMenu>
    with SingleTickerProviderStateMixin {
  AllShipmentController allShipmentController =
      Get.put(AllShipmentController());
  List<CustomerDetails> customerDetailslist = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allShipmentController.fetchAllShipmentData(widget.loginList);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: allShipmentController.allshipmentList != null
            ? allShipmentController.allshipmentList!.length
            : 0,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: PackageMenuCard(
              index: index,
              context: context,
              loginList: widget.loginList,
            ),
          );
        });
  }
}
