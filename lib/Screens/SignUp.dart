import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopuo/Components/Button/ButtonComponent.dart';
import 'package:shopuo/Components/Input/TextInputComponent.dart';
import 'package:shopuo/Services/OverlayService.dart';
import 'package:shopuo/Styles/Color.dart';
import 'package:shopuo/Styles/Typography.dart';
import 'package:shopuo/locator.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final overlayService = locator<OverlayService>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/sign_up_background.jpg"),
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            titleSpacing: 0,
            title: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: [
                  Transform.translate(
                    offset: Offset(-10, 0),
                    child: SvgPicture.asset(
                      "assets/svg_icons/chevron-left.svg",
                      height: 28,
                      width: 28,
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0x000000).withOpacity(0),
                      Color(0x000000).withOpacity(1),
                    ],
                    end: Alignment(0, .8),
                    begin: Alignment.topCenter,
                  ),
                ),
              ),
              ListView(
                padding: EdgeInsets.symmetric(horizontal: 25),
                children: [
                  SizedBox(
                    height: 32,
                  ),
                  Text(
                    "Let's Get Started",
                    style: MyTypography.heading2SB,
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: 210,
                      child: Text(
                        "Signing up or login to see our top picks for you.",
                        style: MyTypography.heading5L,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 44,
                  ),
                  TextInputComponent(
                    hintText: "johndoe@gmail.com",
                    header: "Email Address",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextInputComponent(
                    hintText: "*******",
                    header: "Password",
                    obscure: true,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ButtonComponent(
                    text: "Sign In",
                    onTap: () => {},
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      "Forget Password?",
                      style: MyTypography.heading6R.copyWith(
                        color: MyColor.primaryPurple,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Center(
                    child: Text(
                      "OR",
                      style: MyTypography.heading6R.copyWith(
                        color: MyColor.neutralGrey3,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ButtonComponent(
                    text: "Continue with Google",
                    icon: "assets/svg_icons/google.svg",
                    color: MyColor.primaryBlue1,
                    onTap: () async {
                      bool value = await overlayService.showPaymentDialog();
                      print(value);
                    },
                  ),
                  SizedBox(
                    height: 44,
                  ),
                  Center(
                    child: Text(
                      "Already have an account?",
                      style: MyTypography.heading6R.copyWith(
                        color: MyColor.primaryPurple,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
