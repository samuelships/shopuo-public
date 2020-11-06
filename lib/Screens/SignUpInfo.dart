import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopuo/Components/Button/ButtonComponent.dart';
import 'package:shopuo/Components/Input/TextInputComponent.dart';
import 'package:shopuo/Styles/Color.dart';
import 'package:shopuo/Styles/Typography.dart';
import 'package:shopuo/ViewModels/SignUpInfoViewModel.dart';

import '../locator.dart';

class SignUpInfo extends StatefulWidget {
  static Widget create() {
    return ChangeNotifierProvider<SignUpInfoViewModel>(
      create: (_) => locator<SignUpInfoViewModel>(),
      child: SignUpInfo(),
    );
  }

  @override
  _SignUpInfoState createState() => _SignUpInfoState();
}

class _SignUpInfoState extends State<SignUpInfo> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpInfoViewModel>(
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            ListView(
              padding: EdgeInsets.symmetric(horizontal: 25),
              children: [
                SizedBox(
                  height: 50,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    width: 190,
                    child: Text(
                      "Finish the signup process",
                      style: MyTypography.heading2SB.copyWith(
                        color: MyColor.neutralBlack,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    width: 325,
                    child: Text(
                      "Finish by providing more details for a tailored experience.",
                      style: MyTypography.heading5L.copyWith(
                        color: MyColor.neutralGrey3,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
                TextInputComponent(
                  hintText: "Full name",
                  leadingIcon: "assets/svg_icons/user.svg",
                  onChanged: (value) {
                    setState(() {
                      model.fullName.change(value);
                    });
                  },
                  error: model.fullName.error,
                ),
                SizedBox(
                  height: 20,
                ),
                TextInputComponent(
                  hintText: "Phone number",
                  leadingIcon: "assets/svg_icons/smartphone.svg",
                  onChanged: (value) {
                    setState(() {
                      model.phoneNumber.change(value);
                    });
                  },
                  error: model.phoneNumber.error,
                ),
              ],
            ),
            Positioned(
              left: 0,
              bottom: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                child: ButtonComponent(
                  text: "Next",
                  onTap: model.sendInfo,
                  active: !model.inProgress,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
