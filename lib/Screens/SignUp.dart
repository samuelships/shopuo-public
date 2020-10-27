import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopuo/Components/Button/ButtonComponent.dart';
import 'package:shopuo/Components/HeaderComponent.dart';
import 'package:shopuo/Components/Input/TextInputComponent.dart';
import 'package:shopuo/Services/OverlayService.dart';
import 'package:shopuo/Styles/Color.dart';
import 'package:shopuo/Styles/Typography.dart';
import 'package:shopuo/ViewModels/SignUpViewModel.dart';
import 'package:shopuo/locator.dart';

class SignUp extends StatefulWidget {
  static Widget create({child}) {
    return ChangeNotifierProvider<SignUpViewModel>(
      create: (_) => locator<SignUpViewModel>(),
      child: SignUp(),
    );
  }

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final overlayService = locator<OverlayService>();

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpViewModel>(
      builder: (_, model, __) => SafeArea(
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
            appBar: HeaderComponent(
              leading: "assets/svg_icons/chevron-left.svg",
              leadingCallback: () {
                Navigator.of(context).pop();
              },
              background: Colors.transparent,
              leadingColor: Colors.white,
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
                      onChanged: (value) {
                        setState(() {
                          model.email.change(value);
                        });
                      },
                      error: model.email.error,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextInputComponent(
                      hintText: "*******",
                      header: "Password",
                      obscure: true,
                      onChanged: (value) {
                        setState(() {
                          model.password.change(value);
                        });
                      },
                      error: model.password.error,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ButtonComponent(
                      text: "Sign Up",
                      onTap: model.signUpWithEmailAndPassword,
                      active: !model.signUpInProgress,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: model.goToResetPassword,
                      child: Center(
                        child: Text(
                          "Forget Password?",
                          style: MyTypography.heading6R.copyWith(
                            color: MyColor.primaryPurple,
                          ),
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
                      onTap: model.continueWithGoogle,
                    ),
                    SizedBox(
                      height: 44,
                    ),
                    GestureDetector(
                      onTap: Navigator.of(context).pop,
                      child: Center(
                        child: Text(
                          "Already have an account?",
                          style: MyTypography.heading6R.copyWith(
                            color: MyColor.primaryPurple,
                          ),
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
      ),
    );
  }
}
