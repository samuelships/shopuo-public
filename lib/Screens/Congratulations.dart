import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopuo/Components/Button/ButtonComponent.dart';
import 'package:shopuo/Styles/Color.dart';
import 'package:shopuo/Styles/Typography.dart';

class Congratulations extends StatefulWidget {
  @override
  _CongratulationsState createState() => _CongratulationsState();
}

class _CongratulationsState extends State<Congratulations> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: (Stack(
          fit: StackFit.expand,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                SvgPicture.asset("assets/svg_icons/check-circle.svg"),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Congratulations",
                  style: MyTypography.heading1R
                      .copyWith(color: MyColor.neutralBlack),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: 170,
                  child: Text(
                    "Your items are on the way and should arrive shortly",
                    style: MyTypography.bodyInput.copyWith(
                      color: MyColor.neutralGrey3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                  child: ButtonComponent(
                    text: "Track your order",
                    onTap: () {},
                  ),
                )
              ],
            )
          ],
        )),
      ),
    );
  }
}
