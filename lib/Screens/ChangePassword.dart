import 'package:flutter/material.dart';
import 'package:shopuo/Components/Button/ButtonComponent.dart';
import 'package:shopuo/Components/HeaderComponent.dart';
import 'package:shopuo/Components/Input/TextInputComponent.dart';
import 'package:shopuo/Styles/Color.dart';
import 'package:shopuo/Styles/Typography.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: HeaderComponent(
          leading: "assets/svg_icons/chevron-left.svg",
          title: "Change Password",
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 25),
          children: [
            SizedBox(
              height: 25,
            ),
            TextInputComponent(
              header: "New Password",
              headerStyle: MyTypography.heading6SB.copyWith(
                color: MyColor.neutralBlack,
              ),
              hintText: "********",
              obscure: true,
            ),
          ],
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          child: ButtonComponent(
            text: "Save Changes",
            onTap: () {},
          ),
        ),
      ),
    );
  }
}
