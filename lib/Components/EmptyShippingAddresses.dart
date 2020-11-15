import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopuo/Styles/Color.dart';
import 'package:shopuo/Styles/Typography.dart';

class EmptyShippingAddresses extends StatelessWidget {
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
              "You don’t have any addresses",
              textAlign: TextAlign.center,
              style: MyTypography.heading4SB.copyWith(
                color: MyColor.neutralBlack,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            width: 325,
            child: Text(
              "Please go to settings, add shipping addresses and add atleast one shipping address to continue",
              textAlign: TextAlign.center,
              style: MyTypography.bodyInput.copyWith(
                color: MyColor.neutralGrey3,
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          SvgPicture.asset(
            "assets/svg_icons/truck.svg",
            width: 160,
            height: 160,
            color: MyColor.neutralGrey3,
          )
        ],
      ),
    );
  }
}
