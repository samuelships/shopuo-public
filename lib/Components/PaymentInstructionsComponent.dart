import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shopuo/Components/PopupComponent.dart';
import 'package:shopuo/Styles/Color.dart';
import 'package:shopuo/Styles/Typography.dart';

class PaymentInstructionsComponent extends StatefulWidget {
  final Function dismissCallback;
  final Function onOkay;

  const PaymentInstructionsComponent(
      {Key key, this.dismissCallback, this.onOkay})
      : super(key: key);
  @override
  _PaymentInstructionsComponentState createState() =>
      _PaymentInstructionsComponentState();
}

class _PaymentInstructionsComponentState
    extends State<PaymentInstructionsComponent> {
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
                  "assets/svg_icons/monthly-salary.svg",
                  width: 28,
                  color: MyColor.primaryGreen,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Payment Instructions",
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
                "You would be redirected and a push notification will been sent to your phone, do you like to continue?",
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
