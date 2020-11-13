import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopuo/Styles/Color.dart';
import 'package:shopuo/Styles/Typography.dart';

class EmptyCartComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
          ),
          SizedBox(
            width: 325,
            child: Text(
              "You don’t have any item in your cart",
              textAlign: TextAlign.center,
              style: MyTypography.heading4SB.copyWith(
                color: MyColor.neutralBlack,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Add items to continue.",
            style: MyTypography.bodyInput.copyWith(
              color: MyColor.neutralGrey3,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          SvgPicture.asset(
            "assets/svg_icons/shopping-bag.svg",
            width: 160,
            height: 160,
            color: MyColor.neutralGrey3,
          )
        ],
      ),
    );
  }
}
