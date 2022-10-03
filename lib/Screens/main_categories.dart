import 'package:logistics/components/main_categorycard.dart';
import 'package:logistics/models/login_model.dart';
import 'package:logistics/models/mainmenu_model.dart';
import 'package:flutter/material.dart';

class MainCategories extends StatelessWidget {
  List<Login> loginList = [];

  MainCategories({Key? key, required this.loginList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: mainmenuModel.length,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: mainmenuCard(
                    context: context,
                    index: index,
                    loginList: loginList,
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
