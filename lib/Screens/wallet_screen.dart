import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:http/http.dart' as http;
import 'package:logistics/models/login_model.dart';
import 'package:logistics/models/wallet_model.dart';

class WalletScreen extends StatefulWidget {
  List<Login> loginList = [];
  WalletScreen({Key? key, required this.loginList}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  List<WalletModel> walletDataList = [];

  WalletDatas() async {
    var response = await http.get(Uri.parse(
        'http://185.188.127.100/WaselleApi/api/Driver/GetDriverWalletsDetails?DriverId=${widget.loginList.first.dId}&BranchId=${widget.loginList.first.bId}'));
    final walletData = jsonDecode(response.body);
    print(response.statusCode);
    // print(allshipmentData.length);
    // List<ModelFile> allshipmentList = [];

    setState(() {
      walletDataList = List<WalletModel>.from(
          walletData.map((x) => WalletModel.fromJson(x)));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    WalletDatas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 200,
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
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.arrow_upward,
                                    color: Colors.red,
                                  ),
                                  Column(
                                    children: [
                                      Text('To Pay'),
                                      Text(walletDataList.isNotEmpty
                                          ? '${walletDataList.first.totalCollectedAmount.toString()}'
                                          : '0'),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.arrow_downward,
                                    color: Colors.green,
                                  ),
                                  Column(
                                    children: [
                                      Text('To Recieve'),
                                      Text(walletDataList.isNotEmpty
                                          ? '${walletDataList.first.totalPickupAmount.toString()}'
                                          : '0')
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        height: 1,
                        thickness: 2,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
