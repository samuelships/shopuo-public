import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopuo/Models/ProductModel.dart';
import 'package:shopuo/Styles/Color.dart';
import 'package:shopuo/Styles/Typography.dart';

class ProductCard extends StatefulWidget {
  final ProductModel product;

  const ProductCard({Key key, this.product}) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: MyColor.primaryPurple.withAlpha(20),
        onTap: () {},
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: Container(
                child: CachedNetworkImage(
                  fadeOutDuration: Duration(milliseconds: 0),
                  fadeInDuration: Duration(milliseconds: 0),
                  fadeInCurve: Curves.linear,
                  fit: BoxFit.cover,
                  imageUrl: widget.product.image,
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
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.name,
                      style: MyTypography.heading5SB.copyWith(
                        color: MyColor.neutralBlack,
                      ),
                    ),
                    Spacer(flex: 2),
                    Text(
                      (widget.product.category as String).toUpperCase(),
                      style: MyTypography.button2.copyWith(
                        color: MyColor.primaryPurple,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "\$${widget.product.price}",
                      style: MyTypography.heading6R.copyWith(
                        color: MyColor.neutralBlack,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
