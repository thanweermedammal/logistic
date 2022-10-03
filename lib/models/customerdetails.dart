// To parse this JSON data, do
//
//     final customerDetails = customerDetailsFromJson(jsonString);

import 'dart:convert';

List<CustomerDetails> customerDetailsFromJson(String str) =>
    List<CustomerDetails>.from(
        json.decode(str).map((x) => CustomerDetails.fromJson(x)));

String customerDetailsToJson(List<CustomerDetails> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CustomerDetails {
  CustomerDetails({
    this.shipperId,
    this.sId,
    this.branchId,
    this.name,
    this.userName,
    this.password,
    this.country,
    this.address,
    this.mobile,
    this.language,
    this.logoPath,
    this.isActive,
    this.isDelete,
    this.date,
    this.companyName,
    this.phoneNumber,
    this.state,
    this.city,
    this.zipCode,
    this.googleLocation,
    this.rateLevelDomestic,
    this.rateLevelInternational,
    this.paymentType,
    this.deliveryCharge,
    this.cancellationCharge,
    this.bankName,
    this.accountNumber,
    this.typeOfAccount,
    this.tblBranch,
    this.tblBranchItemRecieving,
    this.tblBranchItemRecievingDetails,
    this.tblPickUpRequest,
    this.tblProduct,
    this.tblRequest,
    this.tblUser,
    this.tblPaymentTransactions,
    this.tblShipperRequest,
  });

  int? shipperId;
  dynamic sId;
  int? branchId;
  String? name;
  dynamic userName;
  dynamic password;
  dynamic country;
  String? address;
  String? mobile;
  dynamic language;
  dynamic logoPath;
  dynamic isActive;
  dynamic isDelete;
  dynamic date;
  dynamic companyName;
  dynamic phoneNumber;
  dynamic state;
  dynamic city;
  dynamic zipCode;
  String? googleLocation;
  dynamic rateLevelDomestic;
  dynamic rateLevelInternational;
  dynamic paymentType;
  dynamic deliveryCharge;
  dynamic cancellationCharge;
  dynamic bankName;
  dynamic accountNumber;
  dynamic typeOfAccount;
  dynamic tblBranch;
  List<dynamic>? tblBranchItemRecieving;
  List<dynamic>? tblBranchItemRecievingDetails;
  List<dynamic>? tblPickUpRequest;
  List<dynamic>? tblProduct;
  List<dynamic>? tblRequest;
  List<dynamic>? tblUser;
  List<dynamic>? tblPaymentTransactions;
  List<dynamic>? tblShipperRequest;

  factory CustomerDetails.fromJson(Map<String, dynamic> json) =>
      CustomerDetails(
        shipperId: json["ShipperId"],
        sId: json["SId"],
        branchId: json["BranchID"],
        name: json["Name"],
        userName: json["UserName"],
        password: json["Password"],
        country: json["Country"],
        address: json["Address"],
        mobile: json["Mobile"],
        language: json["Language"],
        logoPath: json["LogoPath"],
        isActive: json["IsActive"],
        isDelete: json["IsDelete"],
        date: json["Date"],
        companyName: json["CompanyName"],
        phoneNumber: json["PhoneNumber"],
        state: json["State"],
        city: json["City"],
        zipCode: json["ZipCode"],
        googleLocation: json["GoogleLocation"],
        rateLevelDomestic: json["RateLevelDomestic"],
        rateLevelInternational: json["RateLevelInternational"],
        paymentType: json["PaymentType"],
        deliveryCharge: json["DeliveryCharge"],
        cancellationCharge: json["CancellationCharge"],
        bankName: json["BankName"],
        accountNumber: json["AccountNumber"],
        typeOfAccount: json["TypeOfAccount"],
        tblBranch: json["Tbl_Branch"],
        tblBranchItemRecieving:
            List<dynamic>.from(json["Tbl_Branch_Item_Recieving"].map((x) => x)),
        tblBranchItemRecievingDetails: List<dynamic>.from(
            json["Tbl_Branch_Item_Recieving_Details"].map((x) => x)),
        tblPickUpRequest:
            List<dynamic>.from(json["Tbl_PickUpRequest"].map((x) => x)),
        tblProduct: List<dynamic>.from(json["Tbl_Product"].map((x) => x)),
        tblRequest: List<dynamic>.from(json["Tbl_Request"].map((x) => x)),
        tblUser: List<dynamic>.from(json["Tbl_User"].map((x) => x)),
        tblPaymentTransactions:
            List<dynamic>.from(json["Tbl_Payment_Transactions"].map((x) => x)),
        tblShipperRequest:
            List<dynamic>.from(json["Tbl_ShipperRequest"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "ShipperId": shipperId,
        "SId": sId,
        "BranchID": branchId,
        "Name": name,
        "UserName": userName,
        "Password": password,
        "Country": country,
        "Address": address,
        "Mobile": mobile,
        "Language": language,
        "LogoPath": logoPath,
        "IsActive": isActive,
        "IsDelete": isDelete,
        "Date": date,
        "CompanyName": companyName,
        "PhoneNumber": phoneNumber,
        "State": state,
        "City": city,
        "ZipCode": zipCode,
        "GoogleLocation": googleLocation,
        "RateLevelDomestic": rateLevelDomestic,
        "RateLevelInternational": rateLevelInternational,
        "PaymentType": paymentType,
        "DeliveryCharge": deliveryCharge,
        "CancellationCharge": cancellationCharge,
        "BankName": bankName,
        "AccountNumber": accountNumber,
        "TypeOfAccount": typeOfAccount,
        "Tbl_Branch": tblBranch,
        "Tbl_Branch_Item_Recieving":
            List<dynamic>.from(tblBranchItemRecieving!.map((x) => x)),
        "Tbl_Branch_Item_Recieving_Details":
            List<dynamic>.from(tblBranchItemRecievingDetails!.map((x) => x)),
        "Tbl_PickUpRequest":
            List<dynamic>.from(tblPickUpRequest!.map((x) => x)),
        "Tbl_Product": List<dynamic>.from(tblProduct!.map((x) => x)),
        "Tbl_Request": List<dynamic>.from(tblRequest!.map((x) => x)),
        "Tbl_User": List<dynamic>.from(tblUser!.map((x) => x)),
        "Tbl_Payment_Transactions":
            List<dynamic>.from(tblPaymentTransactions!.map((x) => x)),
        "Tbl_ShipperRequest":
            List<dynamic>.from(tblShipperRequest!.map((x) => x)),
      };
}
