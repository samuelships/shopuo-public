class ShippingAddressModel {
  final String id;
  final String title;
  final String description;

  ShippingAddressModel({this.title, this.description, this.id});

  factory ShippingAddressModel.fromMap({
    Map<String, dynamic> data,
    String documentId,
  }) {
    return ShippingAddressModel(
      id: documentId,
      title: data["title"],
      description: data["description"],
    );
  }
  @override
  String toString() {
    return "{id : ${this.id}, title : $title, description : $description}";
  }
}
