import 'package:flutter/material.dart';
import 'package:logistics/Screens/subject_detail.dart';
import 'package:logistics/models/subject_model.dart';

Widget subjectCard(
    {@required index, required BuildContext context, required loginList}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SubjectDetail(
            title: subjectModel[index].title,
            loginList: loginList,
          ),
        ),
      );
    },
    child: Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(1, 1),
            blurRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  subjectModel[index].icon,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 15,
            ),
            child: Text(
              subjectModel[index].title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
