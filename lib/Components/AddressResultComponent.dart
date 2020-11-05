import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopuo/Components/AddressCard.dart';
import 'package:shopuo/Models/AddressModel.dart';
import 'package:shopuo/ViewModels/SettingsViewModel.dart';

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
            .map((AddressModel e) => AddressCard(
                  key: ValueKey(e.id),
                  onEdit: () {
                    Provider.of<SettingsViewModel>(context, listen: false)
                        .navigateToEditAddress(
                            id: e.id,
                            title: e.title,
                            description: e.description);
                  },
                  onDelete: () {
                    Provider.of<SettingsViewModel>(context, listen: false)
                        .deleteAddress(id: e.id);
                  },
                  address: e,
                ))
            .toList()
      ],
    );
  }
}
