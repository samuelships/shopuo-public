class CategoryModel {
  final String name;
  final double numberOfItems;
  final String image;

  CategoryModel({this.name, this.numberOfItems, this.image});
}

final List<CategoryModel> categories = [
  CategoryModel(
    name: "Women",
    numberOfItems: 3456,
    image: "assets/images/category_one.png",
  ),
  CategoryModel(
    name: "Men",
    numberOfItems: 3456,
    image: "assets/images/category_two.png",
  ),
  CategoryModel(
    name: "Baby",
    numberOfItems: 3456,
    image: "assets/images/category_three.png",
  ),
  CategoryModel(
    name: "Kids",
    numberOfItems: 3456,
    image: "assets/images/category_four.png",
  ),
  CategoryModel(
    name: "Bags",
    numberOfItems: 3456,
    image: "assets/images/category_five.png",
  ),
  CategoryModel(
    name: "Shoes",
    numberOfItems: 3456,
    image: "assets/images/category_six.png",
  ),
  CategoryModel(
    name: "T-shirts",
    numberOfItems: 3456,
    image: "assets/images/category_seven.png",
  ),
  CategoryModel(
    name: "Pants",
    numberOfItems: 3456,
    image: "assets/images/category_eight.png",
  ),
];
