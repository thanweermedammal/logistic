// import 'dart:convert';
// import 'dart:developer';
// import 'package:http/http.dart' as http;
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
//
// import 'model.dart';
//
// class RemainderScreen extends StatefulWidget {
//   const RemainderScreen({Key? key}) : super(key: key);
//
//   @override
//   _RemainderScreenState createState() => _RemainderScreenState();
// }
//
// class _RemainderScreenState extends State<RemainderScreen> {
//
//   // Reminder reminderModel = new Reminder();
//   List<Reminder> remainderList = [];
//
//
//   @override
//   void initState() {
//
//     getData();
//
//     // });
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: ListView.builder(
//             physics: NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//             itemCount: remainderList.length,
//             itemBuilder: (context, index) {
//               return Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Card(
//                       elevation: 2,
//                       child:Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           children: [
//
//                             Text(
//                                 remainderList[index].reminderDate.toString()
//                             ),
//                             Text(
//                                 remainderList[index].alertText.toString()
//                             ),
//                             Text(
//                                 remainderList[index].reminderTime.toString()
//                             ),
//                           ],
//                         ),
//                       ),
//
//
//                     ),
//                   )
//                 ],
//               );
//             }
//         ),
//       ),
//
//     );
//   }
//   // Future getData() async {
//   //   try {
//   //     String token = '48|vDnkVIDZPZgXYDV1m9o4R0AKiaLujRVSkxI9ZXPm';
//   //     final response = await post(
//   //         Uri.parse(
//   //           'https://dev.boq.wireandswitch.com/api/list_reminder?page_no=0',
//   //         ),
//   //         headers: {
//   //           'Content-Type': 'application/json',
//   //           'Accept': 'application/json',
//   //           'Authorization': 'Bearer $token ',
//   //         });
//   //     if (response.statusCode == 200) {
//   //       Reminder data = reminderFromJson(response.body);
//   //       print(response.body);
//   //       return data;
//   //     } else {
//   //       print(response.statusCode);
//   //     }
//   //   } catch (e) {
//   //     log(e.toString());
//   //     // final data = dataFromJson(response.body);
//   //     // print(data);
//   //     // return data;
//   //   }
//   // }
//
//
//   Future getData() async{
//
//     String token = '48|vDnkVIDZPZgXYDV1m9o4R0AKiaLujRVSkxI9ZXPm';
//     String url='https://dev.boq.wireandswitch.com/api/list_reminder?page_no=0';
//     var response = await http.post(Uri.parse(url),headers:{
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//       'Authorization': 'Bearer $token ',
//     } );
//
//     String responseData=response.body.toString();
//     var jsonData=jsonDecode(responseData);//check response string
//     // if(jsonData['success']) {
//     var data = jsonData['data'];//based on response string give array name
//     remainderList = List<Reminder>.from(data.map((x) => Reminder.fromJson(x)));
//     setState(() {
//
//     });
//   }
// }
