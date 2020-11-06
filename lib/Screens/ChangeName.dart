import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopuo/Components/Button/ButtonComponent.dart';
import 'package:shopuo/Components/HeaderComponent.dart';
import 'package:shopuo/Components/Input/TextInputComponent.dart';
import 'package:shopuo/Styles/Color.dart';
import 'package:shopuo/Styles/Typography.dart';
import 'package:shopuo/ViewModels/SettingsViewModel.dart';

class ChangeName extends StatefulWidget {
  @override
  _ChangeNameState createState() => _ChangeNameState();
}

class _ChangeNameState extends State<ChangeName> {
  TextEditingController _controller;
  SettingsViewModel model;

  @override
  void initState() {
    _controller = TextEditingController();
    model = Provider.of<SettingsViewModel>(context, listen: false);
    _controller.text = model.fullName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsViewModel>(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          appBar: HeaderComponent(
            leading: "assets/svg_icons/chevron-left.svg",
            leadingCallback: Navigator.of(context).pop,
            title: "Change Name",
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
                    controller: _controller,
                    header: "Full name",
                    headerStyle: MyTypography.heading6SB.copyWith(
                      color: MyColor.neutralBlack,
                    ),
                    hintText: "Mark Spencer",
                    onChanged: (value) {
                      setState(() {
                        model.fullNameForm.change(value);
                      });
                    },
                    error: model.fullNameForm.error,
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
                    text: "Save Changes",
                    onTap: model.changeName,
                    active: !model.changeNameInProgress,
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
