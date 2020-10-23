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
    return Column(
      children: [
        Expanded(
          flex: 6,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.product.image),
                fit: BoxFit.cover,
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
                  (widget.product.category.name as String).toUpperCase(),
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
    );
  }
}
