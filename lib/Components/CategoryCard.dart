import 'package:flutter/material.dart';
import 'package:shopuo/Models/CategoryModel.dart';
import 'package:shopuo/Styles/Typography.dart';

class CategoryCard extends StatefulWidget {
  final CategoryModel category;

  const CategoryCard({Key key, this.category}) : super(key: key);

  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(widget.category.image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                child: Text(
                  widget.category.name,
                  style: MyTypography.heading2SB,
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Text(
                "${widget.category.name} items".toUpperCase(),
                style: MyTypography.smallText.copyWith(color: Colors.white),
              ),
            ],
          ),
        )
      ],
    );
  }
}
