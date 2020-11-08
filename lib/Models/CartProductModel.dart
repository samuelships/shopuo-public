class CartProductModel {
  final String id;
  final String productId;
  final String name;
  final double price;
  final String size;
  final String color;
  final int quantity;
  final String image;

  CartProductModel({
    this.id,
    this.productId,
    this.image,
    this.name,
    this.price,
    this.size,
    this.color,
    this.quantity,
  });

  factory CartProductModel.fromMap({
    Map<String, dynamic> data,
    String documentId,
  }) {
    return CartProductModel(
      id: documentId,
      color: data["color"],
      image: data["image"],
      name: data["name"],
      price: double.parse("${data["price"]}"),
      productId: data["product_id"],
      quantity: data["quantity"],
      size: data["size"],
    );
  }

  toString() {
    return "{id: $id, color : $color , name : $name, price : $price, productId : $productId, quantity : $quantity, size : $size}";
  }
}

List<CartProductModel> cartproducts = [
  CartProductModel(
    name: "3 Stripes Shirt",
    price: 30,
    size: "XL",
    color: "Red",
    quantity: 1,
    image: "assets/images/product_img_one.png",
  ),
  CartProductModel(
    name: "Linear Neat Tee",
    price: 25,
    size: "XL",
    color: "Red",
    quantity: 3,
    image: "assets/images/product_img_two.png",
  ),
  CartProductModel(
    name: "Tuxedo Blouse",
    price: 5,
    size: "XL",
    color: "Red",
    quantity: 1,
    image: "assets/images/product_img_three.png",
  ),
];
