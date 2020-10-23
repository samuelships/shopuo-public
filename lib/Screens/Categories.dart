import 'package:flutter/material.dart';
import 'package:shopuo/Components/BottomNavComponent.dart';
import 'package:shopuo/Components/CategoryCard.dart';
import 'package:shopuo/Components/HeaderComponent.dart';
import "../Models/CategoryModel.dart";

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final List<CategoryModel> _categories = categories;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: HeaderComponent(
          leading: "assets/svg_icons/package.svg",
          title: "Categories",
          trailing: "assets/svg_icons/search.svg",
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                childAspectRatio: 1,
              ),
              itemCount: _categories.length,
              itemBuilder: (contex, index) => CategoryCard(
                category: _categories[index],
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomNavComponent(
          currentIndex: 1,
        ),
      ),
    );
  }
}
