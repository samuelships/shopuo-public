import 'package:flutter/material.dart';
import 'package:shopuo/Components/Button/ButtonComponent.dart';
import 'package:shopuo/Components/HeaderComponent.dart';
import 'package:shopuo/Components/Input/MultilineInputComponent.dart';
import 'package:shopuo/Components/Input/TextInputComponent.dart';
import 'package:shopuo/Styles/Color.dart';
import 'package:shopuo/Styles/Typography.dart';

class EditAddress extends StatefulWidget {
  @override
  _EditAddressState createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: HeaderComponent(
          leading: "assets/svg_icons/chevron-left.svg",
          title: "Edit Address",
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 25),
          children: [
            SizedBox(
              height: 25,
            ),
            TextInputComponent(
              header: "Name",
              headerStyle: MyTypography.heading6SB.copyWith(
                color: MyColor.neutralBlack,
              ),
              hintText: "Warehouse Tema",
            ),
            SizedBox(
              height: 45,
            ),
            MultilineInputComponent(
              header: "Description",
              headerStyle: MyTypography.heading6SB.copyWith(
                color: MyColor.neutralBlack,
              ),
              hintText: "KFC Agbobga round about, Mark Clevand Road",
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
