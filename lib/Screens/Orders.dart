import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopuo/Components/HeaderComponent.dart';
import 'package:shopuo/Components/OrderCard.dart';
import 'package:shopuo/Models/OrderModel.dart';
import 'package:shopuo/ViewModels/OrdersViewModel.dart';

import '../locator.dart';

class Orders extends StatefulWidget {
  static Widget create() {
    return ChangeNotifierProvider<OrdersViewModel>(
      create: (_) => locator<OrdersViewModel>(),
      child: Orders(),
    );
  }

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  OrdersViewModel model;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      model = Provider.of<OrdersViewModel>(context, listen: false);
      model.setUpModel();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: HeaderComponent(
          title: "Your Orders",
          leadingCallback: Navigator.of(context).pop,
          leading: "assets/svg_icons/chevron-left.svg",
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 25),
          children: [
            SizedBox(
              height: 25,
            ),
            ...model.orders
                .asMap()
                .map(
                  (index, value) => MapEntry(
                    index,
                    OrderCard(
                      order: model.orders[index],
                    ),
                  ),
                )
                .values
                .toList()
          ],
        ),
      ),
    );
  }
}
