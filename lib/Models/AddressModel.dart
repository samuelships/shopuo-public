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
