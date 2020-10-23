import 'package:flutter/material.dart';
import 'package:shopuo/Components/HeaderComponent.dart';
import 'package:shopuo/Components/OrderCard.dart';
import 'package:shopuo/Models/OrderModel.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  final List<OrderModel> _orders = orders;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: HeaderComponent(
          title: "Your Orders",
          leading: "assets/svg_icons/chevron-left.svg",
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 25),
          children: [
            SizedBox(
              height: 25,
            ),
            ..._orders
                .asMap()
                .map(
                  (index, value) => MapEntry(
                    index,
                    OrderCard(
                      order: _orders[index],
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
