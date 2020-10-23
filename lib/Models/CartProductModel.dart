class CartProductModel {
  final String name;
  final double price;
  final String size;
  final String color;
  final int quantity;
  final String image;

  CartProductModel({
    this.image,
    this.name,
    this.price,
    this.size,
    this.color,
    this.quantity,
  });
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
