import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopuo/Components/CategoryCard.dart';
import 'package:shopuo/Components/HeaderComponent.dart';
import 'package:shopuo/ViewModels/CategoriesViewModel.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final model = Provider.of<CategoriesViewModel>(context, listen: false);
      model.setUpModel();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoriesViewModel>(
      builder: (_, model, __) => SafeArea(
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
                itemCount: model.categories.length,
                itemBuilder: (contex, index) => CategoryCard(
                  category: model.categories[index],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
