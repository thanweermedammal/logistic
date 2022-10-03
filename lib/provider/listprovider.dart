import 'package:flutter/cupertino.dart';
import 'package:logistics/models/login_model.dart';

class DataProvider with ChangeNotifier {
  List<Login>? loginList = [];

  setTotalAmount(loginList) {
    loginList = loginList;
    print(loginList);
    notifyListeners();
  }
}
