import 'dart:ui';

import 'package:shopuo/Models/CategoryModel.dart';
import 'package:shopuo/Styles/Color.dart';

class ProductColor {
  final String name;
  final Color value;

  ProductColor({this.name, this.value});
}

class ProductSize {
  final String name;
  final String value;

  ProductSize({this.name, this.value});
}

class ProductModel {
  final String name;
  final String description;
  final CategoryModel brand;
  final double price;
  final String image;
  final List<String> secondaryImages;
  final CategoryModel category;
  final List<ProductColor> colors;
  final List<ProductSize> sizes;

  ProductModel({
    this.name,
    this.description,
    this.brand,
    this.price,
    this.image,
    this.secondaryImages,
    this.category,
    this.colors,
    this.sizes,
  });
}

final List<ProductModel> products = [
  ProductModel(
    name: "New Balance Raff Simons Bright Color",
    category: CategoryModel(name: "Women"),
    price: 130,
    image: "assets/images/product_img_one.png",
    colors: [
      ProductColor(
        name: "neutralBlack",
        value: MyColor.neutralBlack,
      ),
      ProductColor(
        name: "neutralGrey4",
        value: MyColor.neutralGrey4,
      ),
      ProductColor(
        name: "primaryLila",
        value: MyColor.primaryLila,
      ),
      ProductColor(
        name: "primaryPurple",
        value: MyColor.primaryPurple,
      ),
      ProductColor(
        name: "primarySunflower",
        value: MyColor.primarySunflower,
      ),
      ProductColor(
        name: "primaryOrange",
        value: MyColor.primaryOrange,
      ),
      ProductColor(
        name: "primaryBlue",
        value: MyColor.primaryBlue,
      ),
      ProductColor(
        name: "primaryGreen",
        value: MyColor.primaryGreen,
      ),
      ProductColor(
        name: "primaryRed",
        value: MyColor.primaryRed,
      ),
    ],
    sizes: [
      ProductSize(name: "XS", value: "XS"),
      ProductSize(name: "S", value: "S"),
      ProductSize(name: "M", value: "M"),
      ProductSize(name: "L", value: "L"),
      ProductSize(name: "XL", value: "XL"),
      ProductSize(name: "XXL", value: "XXL"),
    ],
    secondaryImages: [
      "assets/images/details_one.png",
      "assets/images/details_two.png",
      "assets/images/details_three.png",
      "assets/images/details_four.png",
      "assets/images/details_five.png",
      "assets/images/details_one.png",
      "assets/images/details_two.png",
      "assets/images/details_three.png",
      "assets/images/details_four.png",
      "assets/images/details_five.png"
    ],
    description:
        "Enjoy the beauty of italian cotton all over your body. This item will fit your body and warm you up all over and during spring. This item will fit your body and warm you up all over and during spring. And over and over again, this is the text.",
  ),
  ProductModel(
    name: "New Balance Raff Simons Bright Colorr",
    category: CategoryModel(name: "Women"),
    price: 130,
    image: "assets/images/product_img_two.png",
  ),
  ProductModel(
    name: "New Balance Raff Simons Bright Color",
    category: CategoryModel(name: "Women"),
    price: 130,
    image: "assets/images/product_img_three.png",
  ),
  ProductModel(
    name: "New Balance Raff Simons Bright Color",
    category: CategoryModel(name: "Women"),
    price: 130,
    image: "assets/images/product_img_four.png",
  ),
  ProductModel(
    name: "New Balance Raff Simons Bright Color",
    category: CategoryModel(name: "Women"),
    price: 130,
    image: "assets/images/product_img_five.png",
  ),
  ProductModel(
    name: "New Balance Raff Simons Bright Color",
    category: CategoryModel(name: "Women"),
    price: 130,
    image: "assets/images/product_img_six.png",
  ),
];
