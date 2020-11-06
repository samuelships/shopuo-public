import 'package:cached_network_image/cached_network_image.dart';
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
        CachedNetworkImage(
          fadeOutDuration: Duration(milliseconds: 0),
          fadeInDuration: Duration(milliseconds: 0),
          fadeInCurve: Curves.linear,
          fit: BoxFit.cover,
          imageUrl: widget.category.image,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) => Container(
            color: Colors.grey,
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          top: 0,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.white,
              highlightColor: Colors.transparent,
              onTap: () {},
              child: Container(
                color: Colors.black.withOpacity(.4),
              ),
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
