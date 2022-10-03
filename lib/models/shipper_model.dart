// To parse this JSON data, do
//
//     final shipper = shipperFromJson(jsonString);

import 'dart:convert';

List<Shipper> shipperFromJson(String str) =>
    List<Shipper>.from(json.decode(str).map((x) => Shipper.fromJson(x)));

String shipperToJson(List<Shipper> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Shipper {
  Shipper({
    this.shipmentId,
    this.shipperId,
    this.branchId,
    this.itemDescription,
    this.status,
    this.recieverName,
    this.recieverLastName,
    this.recieverAddress1,
    this.recieverAddress2,
    this.recieverCity,
    this.recieveZip,
    this.recieverCondactDeatils,
    this.isCod,
    this.isDelete,
    this.date,
    this.tblBranch,
    this.tblBranchItemRecievingDetails,
    this.tblLog,
    this.tblPickUpRequest,
    this.tblProduct,
    this.tblRequest,
    this.tblTrader,
    this.tblRunSheetDetails,
  });

  int? shipmentId;
  int? shipperId;
  int? branchId;
  String? itemDescription;
  String? status;
  dynamic recieverName;
  dynamic recieverLastName;
  dynamic recieverAddress1;
  dynamic recieverAddress2;
  dynamic recieverCity;
  dynamic recieveZip;
  dynamic recieverCondactDeatils;
  dynamic isCod;
  dynamic isDelete;
  dynamic date;
  dynamic tblBranch;
  List<dynamic>? tblBranchItemRecievingDetails;
  List<dynamic>? tblLog;
  List<dynamic>? tblPickUpRequest;
  List<dynamic>? tblProduct;
  List<dynamic>? tblRequest;
  dynamic tblTrader;
  List<dynamic>? tblRunSheetDetails;

  factory Shipper.fromJson(Map<String, dynamic> json) => Shipper(
        shipmentId: json["ShipmentId"],
        shipperId: json["ShipperId"],
        branchId: json["BranchId"],
        itemDescription: json["ItemDescription"],
        status: json["Status"],
        recieverName: json["RecieverName"],
        recieverLastName: json["RecieverLastName"],
        recieverAddress1: json["RecieverAddress1"],
        recieverAddress2: json["RecieverAddress2"],
        recieverCity: json["RecieverCity"],
        recieveZip: json["RecieveZip"],
        recieverCondactDeatils: json["RecieverCondactDeatils"],
        isCod: json["IsCOD"],
        isDelete: json["IsDelete"],
        date: json["Date"],
        tblBranch: json["Tbl_Branch"],
        tblBranchItemRecievingDetails: List<dynamic>.from(
            json["Tbl_Branch_Item_Recieving_Details"].map((x) => x)),
        tblLog: List<dynamic>.from(json["Tbl_Log"].map((x) => x)),
        tblPickUpRequest:
            List<dynamic>.from(json["Tbl_PickUpRequest"].map((x) => x)),
        tblProduct: List<dynamic>.from(json["Tbl_Product"].map((x) => x)),
        tblRequest: List<dynamic>.from(json["Tbl_Request"].map((x) => x)),
        tblTrader: json["Tbl_Trader"],
        tblRunSheetDetails:
            List<dynamic>.from(json["Tbl_RunSheetDetails"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "ShipmentId": shipmentId,
        "ShipperId": shipperId,
        "BranchId": branchId,
        "ItemDescription": itemDescription,
        "Status": status,
        "RecieverName": recieverName,
        "RecieverLastName": recieverLastName,
        "RecieverAddress1": recieverAddress1,
        "RecieverAddress2": recieverAddress2,
        "RecieverCity": recieverCity,
        "RecieveZip": recieveZip,
        "RecieverCondactDeatils": recieverCondactDeatils,
        "IsCOD": isCod,
        "IsDelete": isDelete,
        "Date": date,
        "Tbl_Branch": tblBranch,
        "Tbl_Branch_Item_Recieving_Details":
            List<dynamic>.from(tblBranchItemRecievingDetails!.map((x) => x)),
        "Tbl_Log": List<dynamic>.from(tblLog!.map((x) => x)),
        "Tbl_PickUpRequest":
            List<dynamic>.from(tblPickUpRequest!.map((x) => x)),
        "Tbl_Product": List<dynamic>.from(tblProduct!.map((x) => x)),
        "Tbl_Request": List<dynamic>.from(tblRequest!.map((x) => x)),
        "Tbl_Trader": tblTrader,
        "Tbl_RunSheetDetails":
            List<dynamic>.from(tblRunSheetDetails!.map((x) => x)),
      };
}
