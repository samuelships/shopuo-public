import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shopuo/Components/PopupComponent.dart';
import 'package:shopuo/Styles/Color.dart';
import 'package:shopuo/Styles/Typography.dart';

class OkayDialogComponent extends StatefulWidget {
  final String icon;
  final String primary;
  final String secondary;
  final Function dismissCallback;
  final Function onOkay;

  const OkayDialogComponent({
    Key key,
    this.dismissCallback,
    this.onOkay,
    this.icon = "assets/svg_icons/monthly-salary.svg",
    this.primary = "Payment Instructions",
    this.secondary =
        "You would be redirected and a push notification will been sent to your phone, do you like to continue?",
  }) : super(key: key);
  @override
  _OkayDialogComponentState createState() => _OkayDialogComponentState();
}

class _OkayDialogComponentState extends State<OkayDialogComponent> {
  @override
  Widget build(BuildContext context) {
    return PopupComponent(
      dismissCallback: widget.dismissCallback,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 24,
            ),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: MyColor.primaryGreen.withOpacity(.3),
              ),
              child: Center(
                child: SvgPicture.asset(
                  widget.icon,
                  width: 28,
                  color: MyColor.primaryGreen,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.primary,
              style: MyTypography.heading5SB.copyWith(
                color: MyColor.neutralGrey1,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 280,
              child: Text(
                widget.secondary,
                textAlign: TextAlign.center,
                style: MyTypography.body2.copyWith(
                  color: MyColor.neutralGrey2,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 1,
              color: Color(0xffE6E4EA),
            ),
            GestureDetector(
              onTap: widget.onOkay,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  "Okay",
                  style: MyTypography.heading5L.copyWith(
                    color: MyColor.primaryPurple,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
