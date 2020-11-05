import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopuo/Components/Button/ButtonComponent.dart';
import 'package:shopuo/Components/HeaderComponent.dart';
import 'package:shopuo/Components/Input/MultilineInputComponent.dart';
import 'package:shopuo/Components/Input/TextInputComponent.dart';
import 'package:shopuo/Styles/Color.dart';
import 'package:shopuo/Styles/Typography.dart';
import 'package:shopuo/ViewModels/SettingsViewModel.dart';

class EditAddress extends StatefulWidget {
  final title;
  final description;
  final id;

  const EditAddress({Key key, this.title, this.description, this.id})
      : super(key: key);
  @override
  _EditAddressState createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  TextEditingController titleController;
  TextEditingController descriptioncontroller;

  @override
  void initState() {
    if (widget.title != null) {
      titleController = TextEditingController(text: widget.title);
      descriptioncontroller = TextEditingController(text: widget.description);
      SettingsViewModel model =
          Provider.of<SettingsViewModel>(context, listen: false);
      model.addressName.change(widget.title);
      model.addressDescription.change(widget.description);
    } else {
      titleController = TextEditingController();
      descriptioncontroller = TextEditingController();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsViewModel>(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: HeaderComponent(
              leading: "assets/svg_icons/chevron-left.svg",
              leadingCallback: Navigator.of(context).pop,
              title: widget.title == null ? "Add Address" : "Edit Address"),
          body: Stack(
            children: [
              ListView(
                padding: EdgeInsets.symmetric(horizontal: 25),
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  TextInputComponent(
                    controller: titleController,
                    header: "Name",
                    headerStyle: MyTypography.heading6SB.copyWith(
                      color: MyColor.neutralBlack,
                    ),
                    hintText: "Warehouse Tema",
                    onChanged: (value) {
                      setState(() {
                        model.addressName.change(value);
                      });
                    },
                    error: model.addressName.error,
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  MultilineInputComponent(
                    controller: descriptioncontroller,
                    header: "Description",
                    headerStyle: MyTypography.heading6SB.copyWith(
                      color: MyColor.neutralBlack,
                    ),
                    hintText: "KFC Agbobga round about, Mark Clevand Road",
                    onChanged: (value) {
                      setState(() {
                        model.addressDescription.change(value);
                      });
                    },
                    error: model.addressDescription.error,
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Container(
                    child: ButtonComponent(
                      text:
                          widget.title == null ? "Add Address" : "SaveChanges",
                      active: !model.addressInProgress,
                      onTap: () {
                        if (widget.title == null) {
                          model.addAddress();
                        } else {
                          model.editAddress(id: widget.id);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
