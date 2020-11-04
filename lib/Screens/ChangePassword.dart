import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopuo/Components/Button/ButtonComponent.dart';
import 'package:shopuo/Components/HeaderComponent.dart';
import 'package:shopuo/Components/Input/TextInputComponent.dart';
import 'package:shopuo/Styles/Color.dart';
import 'package:shopuo/Styles/Typography.dart';
import 'package:shopuo/ViewModels/SettingsViewModel.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsViewModel>(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          appBar: HeaderComponent(
            leading: "assets/svg_icons/chevron-left.svg",
            leadingCallback: Navigator.of(context).pop,
            title: "Change Password",
          ),
          body: Stack(
            children: [
              ListView(
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
                    onChanged: (value) {
                      setState(() {
                        model.passwordForm.change(value);
                      });
                    },
                    error: model.passwordForm.error,
                  ),
                ],
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                  child: ButtonComponent(
                    active: !model.changePasswordInProgress,
                    text: "Save Changes",
                    onTap: model.changePassword,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
