// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_literals_to_create_immutables

import 'package:logistics/Screens/packages_menu.dart';
import 'package:flutter/material.dart';
import 'package:logistics/models/login_model.dart';

class SubjectDetail extends StatefulWidget {
  final title;
  List<Login>loginList=[];
  SubjectDetail({Key? key, required this.title,required this.loginList}) : super(key: key);

  @override
  State<SubjectDetail> createState() => _SubjectDetailState();
}

class _SubjectDetailState extends State<SubjectDetail> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            ),
          ),
          centerTitle: false,
          title: Text(
            widget.title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: TabBar(
                labelColor: Colors.black,
                labelStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  Tab(
                    text: "Chapters",
                  ),
                  Tab(
                    text: "Question & Answers",
                  ),
                  Tab(
                    text: "Exams",
                  ),
                ],
              ),
            ),
          ),
        ),
        body:  TabBarView(
          children: [
            PackagesMenu(loginList: widget.loginList,),
            PackagesMenu(loginList: widget.loginList),
            PackagesMenu(loginList: widget.loginList),
          ],
        ),
      ),
    );
  }
}
