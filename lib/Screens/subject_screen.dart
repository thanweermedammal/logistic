// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:logistics/components/subject_card.dart';
import 'package:logistics/models/login_model.dart';
import 'package:logistics/models/subject_model.dart';
import 'package:flutter/material.dart';

class SubjectScreen extends StatefulWidget {
  final title;
  List<Login> loginList = [];
  SubjectScreen({Key? key, required this.title, required this.loginList})
      : super(key: key);

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: subjectModel.length,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.70,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: subjectCard(
                    context: context,
                    index: index,
                    loginList: widget.loginList,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
