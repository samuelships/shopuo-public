import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopuo/Components/Button/ButtonComponent.dart';
import 'package:shopuo/Components/PopupComponent.dart';
import 'package:shopuo/Styles/Color.dart';
import 'package:shopuo/Styles/Typography.dart';

class DeleteComponent extends StatelessWidget {
  final Function dismissCallback;
  final Function onYes;
  final Function onNo;

  const DeleteComponent({
    Key key,
    this.dismissCallback,
    this.onYes,
    this.onNo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupComponent(
      dismissCallback: dismissCallback,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: MyColor.primaryRed.withOpacity(.3),
              ),
              child: Center(
                child: SvgPicture.asset(
                  "assets/svg_icons/trash-2.svg",
                  width: 28,
                  color: MyColor.primaryRed,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Delete from cart",
              style: MyTypography.heading5SB.copyWith(
                color: MyColor.neutralBlack,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 280,
              child: Text(
                "Do you want to delete this item from cart? Deleting is permanent and cannot be reversed",
                textAlign: TextAlign.center,
                style: MyTypography.body2.copyWith(color: MyColor.neutralBlack),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: ButtonComponent(
                    onTap: onYes,
                    text: "Yes",
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: ButtonComponent(
                    color: MyColor.neutralGrey4,
                    textColor: Colors.black,
                    onTap: onNo,
                    text: "No",
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
