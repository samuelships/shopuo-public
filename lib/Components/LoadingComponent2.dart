import 'package:flutter/material.dart';
import 'package:shopuo/Components/PopupComponent.dart';
import 'package:shopuo/Styles/Color.dart';
import 'package:shopuo/Styles/Typography.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingComponent2 extends StatefulWidget {
  final Function dismissCallback;
  final Function onCancel;

  const LoadingComponent2({Key key, this.dismissCallback, this.onCancel})
      : super(key: key);

  @override
  _LoadingComponent2State createState() => _LoadingComponent2State();
}

class _LoadingComponent2State extends State<LoadingComponent2> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopupComponent(
      dismissCallback: widget.dismissCallback,
      child: Container(
        width: 270,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 24,
            ),
            Container(
              height: 60,
              width: 60,
              child: SpinKitRing(
                color: MyColor.primaryPurple,
                lineWidth: 3,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 1,
              color: Color(0xffE6E4EA),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: GestureDetector(
                onTap: widget.onCancel,
                child: Text(
                  "Cancel",
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
