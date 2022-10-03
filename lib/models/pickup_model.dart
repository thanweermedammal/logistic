class PickupModel {
  final String icon;
  final String customername;
  final String shipid;
  final String distance;
  final String pickaddress;

  PickupModel({
    required this.icon,
    required this.customername,
    required this.shipid,
    required this.distance,
    required this.pickaddress,
  });
}

List<PickupModel> pickupModel = [
  PickupModel(
      customername: "John Doe",
      shipid: "#123456",
      icon: 'assets/images/book.jpg',
      pickaddress: '2nd Street 678 muscat street',
      distance: '2.2 Km'),
  PickupModel(
      customername: "Sajin",
      shipid: "#123456",
      icon: 'assets/images/book.jpg',
      pickaddress: '3rd Street 678 muscat street',
      distance: '3.2 Km'),
  PickupModel(
      customername: "Varghese",
      shipid: "#123456",
      icon: 'assets/images/book.jpg',
      pickaddress: '4th Street 678 muscat street',
      distance: '1.2 Km'),
  PickupModel(
      customername: "Don",
      shipid: "#123456",
      icon: 'assets/images/book.jpg',
      pickaddress: '2nd Street 678 muscat street',
      distance: '4.2 Km'),
  PickupModel(
      customername: "Vincy",
      shipid: "#123456",
      icon: 'assets/images/book.jpg',
      pickaddress: '2nd Street 678 muscat street',
      distance: '2.2 Km'),
];
