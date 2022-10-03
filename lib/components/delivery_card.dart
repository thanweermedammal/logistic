// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:logistics/Screens/pickup_acceptscreen.dart';
import 'package:logistics/models/packages_model.dart';

Widget deliveryCard(
    {@required allshipmentController,
    required BuildContext context,
    required index}) {
  return Container(
    height: 250,
    width: MediaQuery.of(context).size.width,
    clipBehavior: Clip.antiAlias,
    decoration: const BoxDecoration(
      color: Colors.white,
      shape: BoxShape.rectangle,
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          offset: Offset(0, -1),
          blurRadius: 2,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 100,
          color: Color.fromARGB(255, 209, 209, 209),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: Image.asset(
                    packagesModel[index].icon,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Text(
                            "CustomerName : ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            allshipmentController.allshipmentList[index].name
                                .toString(),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Text(
                            "Shipment ID : ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            allshipmentController
                                .allshipmentList[index].shipmentId
                                .toString(),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Deliver to : ",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            allshipmentController.allshipmentList[index].address.toString(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 80, left: 20),
          child: Divider(
            thickness: 0.5,
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Container(
                height: 40,
                width: 120,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => PickAccept(
                    //       custname: item.customername,
                    //       icon: item.icon,
                    //       shipid: item.shipid,
                    //       pickaddress: item.pickaddress,
                    //     ),
                    //   ),
                    // );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: HexColor('17aeb4'),
                  ),
                  child: Text(
                    "Proceed",
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
