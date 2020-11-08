class DeliveryMethod {
  final String id;
  final String name;
  final double price;

  DeliveryMethod({this.name, this.price, this.id});

  factory DeliveryMethod.fromMap({
    Map<String, dynamic> data,
    String documentId,
  }) {
    return DeliveryMethod(
      id: documentId,
      name: data["name"],
      price: double.parse("${data["price"]}"),
    );
  }

  toString() {
    return "{id: $id, name : $name, price : $price";
  }
}

List<DeliveryMethod> deliveryMethods = [
  DeliveryMethod(name: "Standard Delivery", price: 10.00),
  DeliveryMethod(name: "Next Day Delivery", price: 25.00),
];
