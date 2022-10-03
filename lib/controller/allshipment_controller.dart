import 'package:get/get.dart';
import 'package:logistics/Services/alshipment_service.dart';

import 'package:logistics/models/customer_model.dart';
import 'package:logistics/models/customerdetails.dart';
import 'package:logistics/models/shipment_model.dart';

class AllShipmentController extends GetxController {
  AllShipmentService allShipmentService = AllShipmentService();
  List<ModelFile>? allshipmentList;
  List<CustomerDetails>? customerDetailslist;
  RxBool isloading = true.obs;

  fetchAllShipmentData(loginList) async {
    isloading(true);
    print('running');
    allshipmentList = await allShipmentService.getAllShipmentData(loginList);
    print('done');
    isloading(false);
  }

  customerData(index) async {
    isloading(true);
    print('running');
    customerDetailslist = await allShipmentService.customdetails(index);
    print('done');
    isloading(false);
  }
}
