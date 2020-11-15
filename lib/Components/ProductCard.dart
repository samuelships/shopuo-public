import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopuo/Models/ProductModel.dart';
import 'package:shopuo/Styles/Color.dart';
import 'package:shopuo/Styles/Typography.dart';

class ProductCard extends StatefulWidget {
  final ProductModel product;
  final VoidCallback onTap;

  const ProductCard({Key key, this.product, this.onTap}) : super(key: key);

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
        highlightColor: MyColor.primaryPurple.withAlpha(40),
        onTap: widget.onTap,
        child: Column(
          children: [
            Expanded(
              flex: 5,
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
              flex: 4,
              child: Padding(
                padding: EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: MyTypography.heading5SB.copyWith(
                        color: MyColor.neutralBlack,
                      ),
                    ),
                    Spacer(flex: 2),
                    Text(
                      (widget.product.category).toUpperCase(),
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
