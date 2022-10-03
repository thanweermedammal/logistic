import 'package:flutter/material.dart';
import 'package:logistics/Screens/subject_screen.dart';
import 'package:logistics/models/mainmenu_model.dart';

Widget mainmenuCard(
    {@required index, required BuildContext context, required loginList}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubjectScreen(
              title: mainmenuModel[index].title,
              loginList: loginList,
            ),
          ));
    },
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
            child: Image.asset(
              mainmenuModel[index].icon,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            mainmenuModel[index].title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ),
      ],
    ),
  );
}
