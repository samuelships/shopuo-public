class ShippingPlan {
  final String id;
  final String name;
  final double price;

  ShippingPlan({this.name, this.price, this.id});

  factory ShippingPlan.fromMap({
    Map<String, dynamic> data,
    String documentId,
  }) {
    return ShippingPlan(
      id: documentId,
      name: data["name"],
      price: double.parse("${data["price"]}"),
    );
  }

  toString() {
    return "{id: $id, name : $name, price : $price";
  }
}
