class AddressModel {
  final String title;
  final String description;

  AddressModel({this.title, this.description});
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
