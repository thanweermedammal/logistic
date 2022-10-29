class WalletModel {
  String? date;
  int? totalRequest;
  int? totalPickUpCount;
  int? totalDeliveryCount;
  double? totalRequestAmount;
  double? totalDeliveryAmount;
  double? totalCancellationAmount;
  double? totalCollectedAmount;
  double? todayCODAmount;
  double? todayTotalCollectedAmount;
  double? todayTotalDeliveryAmount;
  double? totalPickupAmount;
  double? pickUpCharge;
  double? deliveryCharge;
  double? balanceAmount;
  double? totalRecieptAmount;
  double? totalPaymentAmount;
  String? time;
  String? user;
  String? status;

  WalletModel(
      {this.date,
      this.totalRequest,
      this.totalPickUpCount,
      this.totalDeliveryCount,
      this.totalRequestAmount,
      this.totalDeliveryAmount,
      this.totalCancellationAmount,
      this.totalCollectedAmount,
      this.todayCODAmount,
      this.todayTotalCollectedAmount,
      this.todayTotalDeliveryAmount,
      this.totalPickupAmount,
      this.pickUpCharge,
      this.deliveryCharge,
      this.balanceAmount,
      this.totalRecieptAmount,
      this.totalPaymentAmount,
      this.time,
      this.user,
      this.status});

  WalletModel.fromJson(Map<String, dynamic> json) {
    date = json['Date'];
    totalRequest = json['TotalRequest'];
    totalPickUpCount = json['TotalPickUpCount'];
    totalDeliveryCount = json['TotalDeliveryCount'];
    totalRequestAmount = json['TotalRequestAmount'];
    totalDeliveryAmount = json['TotalDeliveryAmount'];
    totalCancellationAmount = json['TotalCancellationAmount'];
    totalCollectedAmount = json['TotalCollectedAmount'];
    todayCODAmount = json['TodayCODAmount'];
    todayTotalCollectedAmount = json['TodayTotalCollectedAmount'];
    todayTotalDeliveryAmount = json['TodayTotalDeliveryAmount'];
    totalPickupAmount = json['TotalPickupAmount'];
    pickUpCharge = json['PickUpCharge'];
    deliveryCharge = json['DeliveryCharge'];
    balanceAmount = json['BalanceAmount'];
    totalRecieptAmount = json['TotalRecieptAmount'];
    totalPaymentAmount = json['TotalPaymentAmount'];
    time = json['Time'];
    user = json['User'];
    status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Date'] = this.date;
    data['TotalRequest'] = this.totalRequest;
    data['TotalPickUpCount'] = this.totalPickUpCount;
    data['TotalDeliveryCount'] = this.totalDeliveryCount;
    data['TotalRequestAmount'] = this.totalRequestAmount;
    data['TotalDeliveryAmount'] = this.totalDeliveryAmount;
    data['TotalCancellationAmount'] = this.totalCancellationAmount;
    data['TotalCollectedAmount'] = this.totalCollectedAmount;
    data['TodayCODAmount'] = this.todayCODAmount;
    data['TodayTotalCollectedAmount'] = this.todayTotalCollectedAmount;
    data['TodayTotalDeliveryAmount'] = this.todayTotalDeliveryAmount;
    data['TotalPickupAmount'] = this.totalPickupAmount;
    data['PickUpCharge'] = this.pickUpCharge;
    data['DeliveryCharge'] = this.deliveryCharge;
    data['BalanceAmount'] = this.balanceAmount;
    data['TotalRecieptAmount'] = this.totalRecieptAmount;
    data['TotalPaymentAmount'] = this.totalPaymentAmount;
    data['Time'] = this.time;
    data['User'] = this.user;
    data['Status'] = this.status;
    return data;
  }
}
