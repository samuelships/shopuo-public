import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:shopuo/Models/CartProductModel.dart';
import 'package:shopuo/Services/AuthenticationService.dart';
import 'package:shopuo/Services/FirestoreService.dart';
import 'package:shopuo/Services/OverlayService.dart';

import '../locator.dart';

class CartViewModel with ChangeNotifier {
  // SERVICES
  final _firestoreService = locator<FirestoreService>();
  final _authenticationService = locator<AuthenticationService>();
  final _overlayService = locator<OverlayService>();

  // PAGE DATA
  List<CartProductModel> cartproducts = [];
  StreamSubscription cartSubscription;
  bool _cartFetched = false;
  get cartFetched => _cartFetched;
  set cartFetched(value) {
    _cartFetched = value;
    notifyListeners();
  }

  // METHODS
  setUpModel() {
    fetchCart();
  }

  fetchCart() {
    final uid = _authenticationService.currentUser().uid;

    final cartSubscription = _firestoreService
        .collectionStream<CartProductModel>(
      path: "cart/$uid/items",
      builder: (data, documentId) =>
          CartProductModel.fromMap(data: data, documentId: documentId),
    )
        .listen((data) {
      print(data);
      cartproducts = data;
      cartFetched = true;
      notifyListeners();
    });
  }

  fetchDelivery() {}

  @override
  void dispose() {
    cartSubscription.cancel();
    super.dispose();
  }
}
