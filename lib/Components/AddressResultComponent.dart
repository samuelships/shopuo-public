import 'package:flutter/material.dart';
import 'package:shopuo/Components/AddressCard.dart';
import 'package:shopuo/Models/AddressModel.dart';

class AddressResultComponent extends StatelessWidget {
  final loading;
  final List<AddressModel> results;
  final loaded;

  const AddressResultComponent({
    Key key,
    this.loading,
    this.results,
    this.loaded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...results
            .map((e) => AddressCard(
                  address: e,
                ))
            .toList()
      ],
    );
  }
}
