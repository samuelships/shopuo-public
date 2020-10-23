class DeliveryMethod {
  final String name;
  final String description;

  DeliveryMethod({this.name, this.description});
}

List<DeliveryMethod> deliveryMethods = [
  DeliveryMethod(name: "Standard Delivery", description: "\$10.00)"),
  DeliveryMethod(name: "Next Day Delivery", description: "(\$25.00)"),
];
