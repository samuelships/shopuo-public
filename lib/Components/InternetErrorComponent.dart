import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopuo/Components/Button/ButtonComponent.dart';
import 'package:shopuo/Styles/Color.dart';
import 'package:shopuo/Styles/Typography.dart';

class InternetErrorComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(
          flex: 1,
        ),
        Text(
          "No Internet Connections",
          style: MyTypography.heading4SB.copyWith(
            color: MyColor.neutralBlack,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          "Please check your internet connection and try again.",
          style: MyTypography.bodyInput.copyWith(
            color: MyColor.neutralGrey3,
          ),
        ),
        SizedBox(
          height: 50,
        ),
        SvgPicture.asset("assets/svg_icons/link-2.svg"),
        Spacer(
          flex: 5,
        ),
        Container(
          width: 150,
          child: ButtonComponent(
            text: "Try again",
            onTap: () {},
          ),
        ),
        Spacer(
          flex: 1,
        )
      ],
    );
  }
}
