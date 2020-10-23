import 'package:flutter/material.dart';
import 'package:shopuo/Models/SearchModel.dart';
import 'package:shopuo/Styles/Color.dart';
import 'package:shopuo/Styles/Typography.dart';

class SearchCard extends StatelessWidget {
  final SearchModel product;

  const SearchCard({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 85,
            width: 85,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                image: AssetImage(product.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 25,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.brand,
                  style: MyTypography.body1,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  product.name,
                  style: MyTypography.heading5SB.copyWith(
                    color: MyColor.neutralBlack,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text(
                      "\$${product.price}",
                      style: MyTypography.body1,
                    ),
                    Spacer(),
                    Text(
                      "Add to cart",
                      style: MyTypography.body1
                          .copyWith(color: MyColor.primaryPurple),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
