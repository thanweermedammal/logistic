class DeliveryModel {
  final String icon;
  final String customername;
  final String shipid;
  final String distance;
  final String pickaddress;

  DeliveryModel({
    required this.icon,
    required this.customername,
    required this.shipid,
    required this.distance,
    required this.pickaddress,
  });
}

List<DeliveryModel> deliveryModel = [
  DeliveryModel(
      customername: "John Doe",
      shipid: "#123456",
      icon: 'assets/images/book.jpg',
      pickaddress: 'Sheik road,678 muscat street',
      distance: '2.2 Km'),
  DeliveryModel(
      customername: "Sajin",
      shipid: "#123456",
      icon: 'assets/images/book.jpg',
      pickaddress: '2nd Street,678 muscat street',
      distance: '3.5 Km'),
  DeliveryModel(
      customername: "Varghese",
      shipid: "#123456",
      icon: 'assets/images/book.jpg',
      pickaddress: '3rd street,678 muscat street',
      distance: '4.2 Km'),
  DeliveryModel(
      customername: "Don",
      shipid: "#123456",
      icon: 'assets/images/book.jpg',
      pickaddress: '4th Street,678 muscat street',
      distance: '6.2 Km'),
  DeliveryModel(
      customername: "Vincy",
      shipid: "#123456",
      icon: 'assets/images/book.jpg',
      pickaddress: '5th street,678 muscat street',
      distance: '1.2 Km'),
];
