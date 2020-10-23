import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopuo/Components/Button/ButtonComponent.dart';
import 'package:shopuo/Components/Input/TextInputComponent.dart';
import 'package:shopuo/Styles/Color.dart';
import 'package:shopuo/Styles/Typography.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Container(
          padding: EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 10),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: MyColor.dividerLight),
            ),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/svg_icons/x.svg",
                color: MyColor.neutralBlack,
              )
            ],
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15),
        children: [
          SizedBox(
            height: 25,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: 246,
              child: Text(
                "Rest your password to get back in.",
                style: MyTypography.heading2SB
                    .copyWith(color: MyColor.neutralBlack),
              ),
            ),
          ),
          SizedBox(
            height: 70,
          ),
          TextInputComponent(
            hintText: "johndoe@gmail.com",
            header: "Email Address",
            headerStyle:
                MyTypography.heading6SB.copyWith(color: MyColor.neutralBlack),
          ),
          SizedBox(
            height: 20,
          ),
          ButtonComponent(
            text: "Reset Password",
            onTap: () => {},
          )
        ],
      ),
    );
  }
}
