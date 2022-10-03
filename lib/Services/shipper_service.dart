import 'package:http/http.dart' as http;
import 'package:logistics/models/shipper_model.dart';

class ShipperService {
  Future<Shipper> getShipperData() async {
    final response = await http.get(Uri.parse(
        'http://185.188.127.100/WaselleApi/api/Shipment/GetShipmentDetails?ShipperId=2&BranchId=1&ShipmentId=1000'));
    final shipperData = shipperFromJson(response.body);
    print(response.statusCode);
    print('hjj');
    return shipperData[0];
  }
}
