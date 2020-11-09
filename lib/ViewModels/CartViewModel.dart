import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopuo/Models/AddressModel.dart';
import 'package:shopuo/Models/CartProductModel.dart';
import 'package:shopuo/Models/DeliveryMethod.dart';
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
  List<DeliveryMethod> deliveryMethods = [];

  List<AddressModel> shippingAddresses = addresses;

  int _currentShippingAddress = 0;
  get currentShippingAddress => _currentShippingAddress;
  set currentShippingAddress(value) {
    _currentShippingAddress = value;
    notifyListeners();
  }

  get deliveryAmount => deliveryMethods.length == 0
      ? 0
      : deliveryMethods[currentDeliveryMethod].price;
  get orderAmount =>
      cartproducts.fold(0, (acc, curr) => acc + curr.price * curr.quantity);
  get totalAmount => deliveryAmount + orderAmount;

  int _currentDeliveryMethod = 0;
  get currentDeliveryMethod => _currentDeliveryMethod;
  set currentDeliveryMethod(value) {
    _currentDeliveryMethod = value;
    notifyListeners();
  }

  StreamSubscription cartSubscription;

  bool _cartFetched = false;
  get cartFetched => _cartFetched;
  set cartFetched(value) {
    _cartFetched = value;
    notifyListeners();
  }

  bool _deliveryMethodsFetched = false;
  get deliveryMethodsFetched => _deliveryMethodsFetched;
  set deliveryMethodsFetched(value) {
    _deliveryMethodsFetched = value;
    notifyListeners();
  }

  // METHODS
  setUpModel() {
    fetchCart();
    fetchDelivery();
  }

  deleteCartItem({id}) async {
    final uid = _authenticationService.currentUser().uid;

    try {
      await _firestoreService.deleteData("cart/$uid/items/$id");
      notifyListeners();
    } catch (e) {
      print(e);
    }
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
      cartproducts = data;
      cartFetched = true;
      notifyListeners();
    });
  }

  fetchDelivery() async {
    try {
      deliveryMethods =
          await _firestoreService.getDataCollection<DeliveryMethod>(
        path: "delivery_methods",
        builder: ({
          Map<String, dynamic> data,
          String documentID,
          DocumentSnapshot snapshot,
        }) =>
            DeliveryMethod.fromMap(
          data: data,
          documentId: documentID,
        ),
      );
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    cartSubscription.cancel();
    super.dispose();
  }
}
