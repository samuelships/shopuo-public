import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopuo/Styles/Color.dart';
import 'package:shopuo/Styles/Typography.dart';

class ShippingCard extends StatelessWidget {
  final primary;
  final secondary;
  final selected;
  final index;
  final Function callback;

  const ShippingCard({
    Key key,
    this.callback,
    this.index,
    this.primary,
    this.secondary,
    this.selected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callback(index);
      },
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(bottom: 34),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          border: Border.all(
            color: MyColor.dividerLight,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                color: selected ? MyColor.primaryPurple : Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
                border: Border.all(
                  color:
                      selected ? MyColor.primaryPurple : MyColor.dividerLight,
                ),
              ),
              child: selected
                  ? SvgPicture.asset("assets/svg_icons/check.svg")
                  : Container(),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  primary,
                  style: MyTypography.heading5SB
                      .copyWith(color: MyColor.neutralBlack),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  secondary,
                  style: MyTypography.heading6R
                      .copyWith(color: MyColor.neutralGrey3),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
