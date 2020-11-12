import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopuo/Models/OrderModel.dart';
import 'package:shopuo/Services/AuthenticationService.dart';
import 'package:shopuo/Services/CloudFunctionService.dart';
import 'package:shopuo/Services/FirestoreService.dart';
import 'package:shopuo/Services/OverlayService.dart';

import '../locator.dart';

class OrdersViewModel with ChangeNotifier {
  // SERVICES
  final _firestoreService = locator<FirestoreService>();
  final _authenticationService = locator<AuthenticationService>();
  final _overlayService = locator<OverlayService>();
  final _cloudFunctionService = locator<CloudFunctionService>();

  List<OrderModel> orders = [];

  bool _orderFetched = false;
  get orderFetched => _orderFetched;
  set orderFetched(value) {
    _orderFetched = value;
    notifyListeners();
  }

  // METHODS
  setUpModel() {
    fetchOrders();
  }

  fetchOrders() async {
    final uid = _authenticationService.currentUser().uid;

    try {
      orders = await _firestoreService.getDataCollection<OrderModel>(
          path: "orders",
          queryBuilder: (ref) => ref
              .where(
                "transaction_status",
                isEqualTo: true,
              )
              .where("user_id", isEqualTo: uid),
          builder: ({
            Map<String, dynamic> data,
            String documentID,
            DocumentSnapshot snapshot,
          }) =>
              OrderModel.fromMap(
                data: data,
                documentId: documentID,
              ));

      orderFetched = true;
      print(orders);
    } catch (e) {
      print(e);
    }
  }
}
