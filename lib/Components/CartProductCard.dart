import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shopuo/Models/CartProductModel.dart';
import 'package:shopuo/Styles/Color.dart';
import 'package:shopuo/Styles/Typography.dart';

class CartProductCard extends StatelessWidget {
  final CartProductModel product;

  CartProductCard({this.product});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: MyColor.dividerLight),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 75,
              width: 75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
                image: DecorationImage(
                  image: AssetImage(product.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        product.name,
                        style: MyTypography.heading6SB.copyWith(
                          color: MyColor.neutralBlack,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "\$${product.price}",
                        style: MyTypography.smallText,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Size: ",
                      style: MyTypography.smallText,
                      children: [
                        TextSpan(
                          text: " ${product.size}",
                          style: MyTypography.smallText.copyWith(
                            color: MyColor.neutralGrey3,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Color: ",
                      style: MyTypography.smallText,
                      children: [
                        TextSpan(
                          text: " ${product.color}",
                          style: MyTypography.smallText.copyWith(
                            color: MyColor.neutralGrey3,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Quantity: ",
                      style: MyTypography.smallText,
                      children: [
                        TextSpan(
                          text: " ${product.quantity}",
                          style: MyTypography.smallText.copyWith(
                            color: MyColor.neutralGrey3,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      secondaryActions: <Widget>[
        Container(
          color: MyColor.primaryGreen,
          child: Center(
            child: SvgPicture.asset(
              "assets/svg_icons/edit-2.svg",
              height: 52,
            ),
          ),
        ),
        Container(
          color: MyColor.primaryRed,
          child: Center(
            child: SvgPicture.asset(
              "assets/svg_icons/trash-2.svg",
              height: 52,
            ),
          ),
        ),
      ],
    );
  }
}
