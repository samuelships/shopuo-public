import 'package:flutter/cupertino.dart';
import 'package:shopuo/Models/ProductModel.dart';
import 'package:shopuo/Services/AuthenticationService.dart';
import 'package:shopuo/Services/FirestoreService.dart';
import 'package:shopuo/Services/OverlayService.dart';
import 'package:shopuo/locator.dart';

class ProductDetailsViewModel with ChangeNotifier {
  // SERVICES
  final _firestoreService = locator<FirestoreService>();
  final _authenticationService = locator<AuthenticationService>();
  final _overlayService = locator<OverlayService>();

  // PAGEDATA
  bool _isAddProductToCartInProgress = false;
  get isAddProductToCartInProgress => _isAddProductToCartInProgress;
  set isAddProductToCartInProgress(value) {
    _isAddProductToCartInProgress = value;
    notifyListeners();
  }

  // METHODS
  addProductToCart({
    ProductModel product,
    String color,
    int quantity,
    String size,
    Function callback,
  }) {
    final uid = _authenticationService.currentUser().uid;

    if (!isAddProductToCartInProgress) {
      isAddProductToCartInProgress = true;
      try {
        _firestoreService
            .setData(path: "cart/$uid/items/${product.documentId}", data: {
          "product_id": product.documentId,
          "price": product.price,
          "size": size,
          "name": product.name,
          "image": product.image,
          "color": color,
          "quantity": quantity,
        });

        _overlayService.showSnackBarSuccess(widget: Text("Added to cart"));
        callback();
      } catch (e) {
        _overlayService.showSnackBarFailure(
            widget: Text("Error adding to cart"));
      }

      isAddProductToCartInProgress = false;
    }
  }
}
