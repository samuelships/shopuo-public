import 'package:flutter/material.dart';
import 'package:shopuo/Components/HeaderComponent.dart';
import 'package:shopuo/Components/ToggleComponent.dart';
import 'package:shopuo/Styles/Color.dart';
import 'package:shopuo/Styles/Typography.dart';

class PushNotification extends StatefulWidget {
  @override
  _PushNotificationState createState() => _PushNotificationState();
}

class _PushNotificationState extends State<PushNotification> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: HeaderComponent(
          leading: "assets/svg_icons/chevron-left.svg",
          title: "Push Notification",
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 25,
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 25),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color(0xffE4E4E4),
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Send Push Notifications",
                        style: MyTypography.heading5L.copyWith(
                          color: MyColor.neutralBlack,
                        ),
                      ),
                      ToggleComponent(
                        onTap: () {},
                        color: MyColor.primaryPurple,
                        position: "end",
                      )
                    ],
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
