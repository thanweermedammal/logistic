// To parse this JSON data, do
//
//     final dataCancel = dataCancelFromJson(jsonString);

import 'dart:convert';

List<DataCancel> dataCancelFromJson(String str) =>
    List<DataCancel>.from(json.decode(str).map((x) => DataCancel.fromJson(x)));

String dataCancelToJson(List<DataCancel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DataCancel {
  DataCancel({
    this.runSheetDetailId,
    this.runsheetId,
    this.status,
    this.statusHeader,
    this.fromAddress,
    this.toAddress,
    this.consigneeMobile,
    this.consigneeName,
    this.codAmount,
    this.pickUpRequestId,
    this.shipmentId,
    this.txnId,
    this.shipperId,
    this.branchId,
    this.customerId,
    this.driverId,
    this.name,
    this.mode,
    this.branchName,
    this.shipperName,
    this.trader,
    this.barcode,
    this.driver,
    this.date,
    this.address,
    this.mobile,
    this.description,
    this.amountRecieved,
    this.payedAmount,
    this.balanceAmount,
    this.totalAmount,
    this.shippingCharge,
  });

  int? runSheetDetailId;
  int? runsheetId;
  Status? status;
  String? statusHeader;
  dynamic fromAddress;
  dynamic toAddress;
  String? consigneeMobile;
  ConsigneeName? consigneeName;
  double? codAmount;
  int? pickUpRequestId;
  int? shipmentId;
  int? txnId;
  int? shipperId;
  int? branchId;
  int? customerId;
  int? driverId;
  dynamic name;
  dynamic mode;
  dynamic branchName;
  dynamic shipperName;
  dynamic trader;
  String? barcode;
  dynamic driver;
  DateTime? date;
  dynamic address;
  dynamic mobile;
  dynamic description;
  double? amountRecieved;
  double? payedAmount;
  double? balanceAmount;
  double? totalAmount;
  double? shippingCharge;

  factory DataCancel.fromJson(Map<String, dynamic> json) => DataCancel(
        runSheetDetailId: json["RunSheetDetailId"],
        runsheetId: json["RunsheetId"],
        status: statusValues.map[json["Status"]],
        statusHeader: json["StatusHeader"],
        fromAddress: json["FromAddress"],
        toAddress: json["ToAddress"],
        consigneeMobile: json["ConsigneeMobile"],
        consigneeName: consigneeNameValues.map[json["ConsigneeName"]],
        codAmount: json["CODAmount"],
        pickUpRequestId: json["PickUpRequestId"],
        shipmentId: json["ShipmentId"],
        txnId: json["TxnId"],
        shipperId: json["ShipperId"],
        branchId: json["BranchId"],
        customerId: json["CustomerId"],
        driverId: json["DriverId"],
        name: json["Name"],
        mode: json["Mode"],
        branchName: json["BranchName"],
        shipperName: json["ShipperName"],
        trader: json["Trader"],
        barcode: json["Barcode"],
        driver: json["Driver"],
        date: DateTime.parse(json["Date"]),
        address: json["Address"],
        mobile: json["Mobile"],
        description: json["Description"],
        amountRecieved: json["AmountRecieved"],
        payedAmount: json["PayedAmount"],
        balanceAmount: json["BalanceAmount"],
        totalAmount: json["TotalAmount"],
        shippingCharge: json["ShippingCharge"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "RunSheetDetailId": runSheetDetailId,
        "RunsheetId": runsheetId,
        "Status": statusValues.reverse[status],
        "StatusHeader": statusHeader,
        "FromAddress": fromAddress,
        "ToAddress": toAddress,
        "ConsigneeMobile": consigneeMobile,
        "ConsigneeName": consigneeNameValues.reverse[consigneeName],
        "CODAmount": codAmount,
        "PickUpRequestId": pickUpRequestId,
        "ShipmentId": shipmentId,
        "TxnId": txnId,
        "ShipperId": shipperId,
        "BranchId": branchId,
        "CustomerId": customerId,
        "DriverId": driverId,
        "Name": name,
        "Mode": mode,
        "BranchName": branchName,
        "ShipperName": shipperName,
        "Trader": trader,
        "Barcode": barcode,
        "Driver": driver,
        "Date": date?.toIso8601String(),
        "Address": address,
        "Mobile": mobile,
        "Description": description,
        "AmountRecieved": amountRecieved,
        "PayedAmount": payedAmount,
        "BalanceAmount": balanceAmount,
        "TotalAmount": totalAmount,
        "ShippingCharge": shippingCharge,
      };
}

enum ConsigneeName { NK }

final consigneeNameValues = EnumValues({"Nk": ConsigneeName.NK});

enum Status { OK, GENERAL, HOLD }

final statusValues = EnumValues(
    {"general": Status.GENERAL, "hold": Status.HOLD, "ok": Status.OK});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
