import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopuo/Components/AddressResultComponent.dart';
import 'package:shopuo/Components/HeaderComponent.dart';
import 'package:shopuo/Components/SearchComponent.dart';
import 'package:shopuo/Models/AddressModel.dart';
import 'package:shopuo/ViewModels/SettingsViewModel.dart';

class Address extends StatefulWidget {
  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {
  SettingsViewModel model;

  @override
  void initState() {
    model = Provider.of<SettingsViewModel>(context, listen: false);
    model.setUpAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsViewModel>(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          appBar: HeaderComponent(
            leading: "assets/svg_icons/chevron-left.svg",
            title: "Address",
            leadingCallback: Navigator.of(context).pop,
            trailing: "assets/svg_icons/plus.svg",
            trailingCallback: () {
              Navigator.of(context).pushNamed("AddAddress");
            },
          ),
          body: ListView(
            children: [
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: SearchComponent(
                  icon: "assets/svg_icons/search.svg",
                  hintText: "Search addresses...",
                ),
              ),
              SizedBox(
                height: 40,
              ),
              AddressResultComponent(
                results: model.addresses,
              )
            ],
          ),
        ),
      ),
    );
  }
}
