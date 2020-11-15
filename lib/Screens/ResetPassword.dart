import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopuo/Components/Button/ButtonComponent.dart';
import 'package:shopuo/Components/HeaderComponent.dart';
import 'package:shopuo/Components/Input/TextInputComponent.dart';
import 'package:shopuo/Styles/Color.dart';
import 'package:shopuo/Styles/Typography.dart';
import 'package:shopuo/ViewModels/ResetPasswordViewModel.dart';

import '../locator.dart';

class ResetPassword extends StatefulWidget {
  static Widget create({child}) {
    return ChangeNotifierProvider<ResetPasswordViewModel>(
      create: (_) => locator<ResetPasswordViewModel>(),
      child: ResetPassword(),
    );
  }

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ResetPasswordViewModel>(
      builder: (_, model, __) => Scaffold(
        appBar: HeaderComponent(
          leading: "assets/svg_icons/x.svg",
          leadingCallback: () {
            Navigator.of(context).pop();
          },
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
              headerStyle: MyTypography.heading6SB.copyWith(
                color: MyColor.neutralBlack,
              ),
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
            ButtonComponent(
              text: "Reset Password",
              onTap: model.sendResetPasswordLink,
              active: !model.resetPasswordInProgress,
            )
          ],
        ),
      ),
    );
  }
}
