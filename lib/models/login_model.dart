// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

List<Login> loginFromJson(String str) =>
    List<Login>.from(json.decode(str).map((x) => Login.fromJson(x)));

String loginToJson(List<Login> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Login {
  Login({
    this.dId,
    this.sId,
    this.bId,
    this.rId,
    this.name,
    this.mobile,
    this.alternatemobile,
    this.address,
    this.userName,
    this.password,
    this.logoPath,
    this.isActive,
    this.isDelete,
    this.date,
    this.idNumber,
    this.nameOfBank,
    this.accountNumber,
    this.idProofPath,
    this.cvPath,
    this.language,
    this.routeCode,
    this.collectionCommission,
    this.deliveryCommission,
    this.isOnline,
    this.tblBranch,
    this.tblBranchItemRecieving,
    this.tblBranchItemRecievingDetails,
    this.tblDriverCollectionAmount,
    this.tblRateMaster,
    this.tblPickUpRequest,
    this.tblPickUpRequest1,
    this.tblPickUpRequest2,
    this.tblProduct,
    this.tblUser,
  });

  int? dId;
  dynamic sId;
  int? bId;
  int? rId;
  String? name;
  String? mobile;
  dynamic alternatemobile;
  String? address;
  String? userName;
  dynamic password;
  dynamic logoPath;
  dynamic isActive;
  dynamic isDelete;
  dynamic date;
  String? idNumber;
  String? nameOfBank;
  dynamic accountNumber;
  dynamic idProofPath;
  dynamic cvPath;
  dynamic language;
  String? routeCode;
  double? collectionCommission;
  double? deliveryCommission;
  bool? isOnline;
  dynamic tblBranch;
  List<dynamic>? tblBranchItemRecieving;
  List<dynamic>? tblBranchItemRecievingDetails;
  List<dynamic>? tblDriverCollectionAmount;
  dynamic tblRateMaster;
  List<dynamic>? tblPickUpRequest;
  List<dynamic>? tblPickUpRequest1;
  List<dynamic>? tblPickUpRequest2;
  List<dynamic>? tblProduct;
  List<dynamic>? tblUser;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        dId: json["DId"],
        sId: json["SId"],
        bId: json["BId"],
        rId: json["RId"],
        name: json["Name"],
        mobile: json["Mobile"],
        alternatemobile: json["Alternatemobile"],
        address: json["Address"],
        userName: json["UserName"],
        password: json["Password"],
        logoPath: json["LogoPath"],
        isActive: json["IsActive"],
        isDelete: json["IsDelete"],
        date: json["Date"],
        idNumber: json["IdNumber"],
        nameOfBank: json["NameOfBank"],
        accountNumber: json["AccountNumber"],
        idProofPath: json["IdProofPath"],
        cvPath: json["CvPath"],
        language: json["Language"],
        routeCode: json["RouteCode"],
        collectionCommission: json["Collection_Commission"],
        deliveryCommission: json["Delivery_Commission"],
        isOnline: json["IsOnline"],
        tblBranch: json["Tbl_Branch"],
        tblBranchItemRecieving:
            List<dynamic>.from(json["Tbl_Branch_Item_Recieving"].map((x) => x)),
        tblBranchItemRecievingDetails: List<dynamic>.from(
            json["Tbl_Branch_Item_Recieving_Details"].map((x) => x)),
        tblDriverCollectionAmount: json["Tbl_Driver_Collection_Amount"] != null
            ? new List<dynamic>.from(
                json["Tbl_Driver_Collection_Amount"].map((x) => x))
            : <dynamic>[],
        tblRateMaster: json["Tbl_RateMaster"],
        tblPickUpRequest:
            List<dynamic>.from(json["Tbl_PickUpRequest"].map((x) => x)),
        tblPickUpRequest1:
            List<dynamic>.from(json["Tbl_PickUpRequest1"].map((x) => x)),
        tblPickUpRequest2:
            List<dynamic>.from(json["Tbl_PickUpRequest2"].map((x) => x)),
        tblProduct: List<dynamic>.from(json["Tbl_Product"].map((x) => x)),
        tblUser: List<dynamic>.from(json["Tbl_User"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "DId": dId,
        "SId": sId,
        "BId": bId,
        "RId": rId,
        "Name": name,
        "Mobile": mobile,
        "Alternatemobile": alternatemobile,
        "Address": address,
        "UserName": userName,
        "Password": password,
        "LogoPath": logoPath,
        "IsActive": isActive,
        "IsDelete": isDelete,
        "Date": date,
        "IdNumber": idNumber,
        "NameOfBank": nameOfBank,
        "AccountNumber": accountNumber,
        "IdProofPath": idProofPath,
        "CvPath": cvPath,
        "Language": language,
        "RouteCode": routeCode,
        "Collection_Commission": collectionCommission,
        "Delivery_Commission": deliveryCommission,
        "IsOnline": isOnline,
        "Tbl_Branch": tblBranch,
        "Tbl_Branch_Item_Recieving":
            List<dynamic>.from(tblBranchItemRecieving!.map((x) => x)),
        "Tbl_Branch_Item_Recieving_Details":
            List<dynamic>.from(tblBranchItemRecievingDetails!.map((x) => x)),
        "Tbl_Driver_Collection_Amount":
            List<dynamic>.from(tblDriverCollectionAmount!.map((x) => x)),
        "Tbl_RateMaster": tblRateMaster,
        "Tbl_PickUpRequest":
            List<dynamic>.from(tblPickUpRequest!.map((x) => x)),
        "Tbl_PickUpRequest1":
            List<dynamic>.from(tblPickUpRequest1!.map((x) => x)),
        "Tbl_PickUpRequest2":
            List<dynamic>.from(tblPickUpRequest2!.map((x) => x)),
        "Tbl_Product": List<dynamic>.from(tblProduct!.map((x) => x)),
        "Tbl_User": List<dynamic>.from(tblUser!.map((x) => x)),
      };
}
