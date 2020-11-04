class AddressModel {
  final String id;
  final String title;
  final String description;

  AddressModel({this.title, this.description, this.id});

  factory AddressModel.fromMap({
    Map<String, dynamic> data,
    String documentId,
  }) {
    return AddressModel(
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

final List<AddressModel> addresses = [
  AddressModel(
    title: "Home Adress",
    description: "Haatso, Asore Junction Transitions 123 Road...",
  ),
  AddressModel(
    title: "John’s House",
    description: "Kwabenya, Abom Junctions 512 Street",
  ),
  AddressModel(
    title: "Warehouse Tema",
    description: "KFC Agbobga round about, Mark Clevand Road",
  ),
];
