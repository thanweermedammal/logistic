import 'dart:convert';

import 'package:logistics/models/cusdetail.dart';
import 'package:logistics/models/customerdetails.dart';
import 'package:logistics/models/login_model.dart';
import 'package:logistics/models/shipment_model.dart';
import 'package:http/http.dart' as http;
import 'package:logistics/provider/listprovider.dart';
import 'package:provider/provider.dart';

class AllShipmentService {
  List<ModelFile> allshipmentList = [];
  List<CustomerDetails> customerDetailslist = [];
  List<Login> loginList1 = [];
  Future getAllShipmentData(loginList) async {
    loginList1 = loginList;
    final response = await http.get(Uri.parse(
        'http://185.188.127.100/WaselleApi/api/PickUp/GetPickUpRequest?DriverId=${loginList.first.dId}&BranchId=${loginList.first.bId}'));
    final allshipmentData = jsonDecode(response.body);
    print(response.statusCode);
    // print(allshipmentData.length);
    // List<ModelFile> allshipmentList = [];
    allshipmentList =
        List<ModelFile>.from(allshipmentData.map((x) => ModelFile.fromJson(x)));

    return allshipmentList;
  }

  customdetails(index) async {
    var response = await http.get(Uri.parse(
        'http://185.188.127.100/WaselleApi/api/Shipper/GetAllShipperSearchById?ShipperId=${allshipmentList[index].shipperId}&BranchId=${loginList1.first.bId}'));
    final customerData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print('ok');

      customerDetailslist = List<CustomerDetails>.from(
          customerData.map((x) => CustomerDetails.fromJson(x)));

      return customerDetailslist;
    } else {
      print('errrr');
    }
  }
}
