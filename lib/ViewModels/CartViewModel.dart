import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:formz/formz.dart';
import 'package:shopuo/Models/CartProductModel.dart';
import 'package:shopuo/Models/OrderModel.dart';
import 'package:shopuo/Models/ShippingAddressModel.dart';
import 'package:shopuo/Models/ShippingPlanModel.dart';
import 'package:shopuo/Models/PaymentModels.dart';
import 'package:shopuo/Services/AuthenticationService.dart';
import 'package:shopuo/Services/CloudFunctionService.dart';
import 'package:shopuo/Services/FirestoreService.dart';
import 'package:shopuo/Services/NavigationService.dart';
import 'package:shopuo/Services/OverlayService.dart';
import 'package:shopuo/Validators/CardMonthValidator.dart';
import 'package:shopuo/Validators/CardNumberValidator.dart';
import 'package:shopuo/Validators/CardCvvValidator.dart';
import 'package:shopuo/Validators/CardYearValidator.dart';
import 'package:shopuo/Validators/FormValidator.dart';
import 'package:shopuo/Validators/FullNameValidator.dart';
import 'package:shopuo/Validators/PhoneNumberValidator.dart';
import 'package:shopuo/Validators/VodafoneVoucherValidator.dart';

import '../locator.dart';

class CartViewModel with ChangeNotifier {
  // SERVICES
  final _firestoreService = locator<FirestoreService>();
  final _authenticationService = locator<AuthenticationService>();
  final _overlayService = locator<OverlayService>();
  final _cloudFunctionService = locator<CloudFunctionService>();
  final _navigationService = locator<NavigationService>();

  // PAGE DATA
  // form data
  FormValidator phoneNumber = FormValidator(validators: phoneNumberValidators);
  FormValidator fullName = FormValidator(validators: fullNameValidators);
  FormValidator cardNumber = FormValidator(validators: cardNumberValidators);
  FormValidator cardCvv = FormValidator(validators: cardCvvValidators);
  FormValidator cardMonth = FormValidator(validators: cardMonthValidators);
  FormValidator cardYear = FormValidator(validators: cardYearValidators);
  FormValidator voucher = FormValidator(validators: vodafoneVoucherValidators);

  get isValid {
    final cp = currentPaymentMethod;

    // mtn and airteltigo
    if (cp == PaymentMethod.MtnMobileMoney ||
        cp == PaymentMethod.AirtelTigoMoney) {
      final inputs = <FormzInput>[phoneNumber.formz];
      return Formz.validate(inputs) == FormzStatus.valid ? true : false;

      // vodafone cash
    } else if (cp == PaymentMethod.VodafoneCash) {
      final inputs = <FormzInput>[phoneNumber.formz, voucher.formz];
      return Formz.validate(inputs) == FormzStatus.valid ? true : false;

      // card
    } else {
      final inputs = <FormzInput>[
        fullName.formz,
        cardNumber.formz,
        cardMonth.formz,
        cardYear.formz,
        cardCvv.formz,
      ];
      return Formz.validate(inputs) == FormzStatus.valid ? true : false;
    }
  }

  // payment methods
  PaymentMethod _currentPaymentMethod = PaymentMethod.MtnMobileMoney;
  get currentPaymentMethod => _currentPaymentMethod;
  set currentPaymentMethod(value) {
    _currentPaymentMethod = value;
    notifyListeners();
  }

  // MobileMoneyModel mobileMoney = MobileMoneyModel();
  // CardModel card = CardModel();

  // cart products
  StreamSubscription cartSubscription;
  StreamSubscription orderSubscription;
  List<CartProductModel> cartproducts = [];

  bool _cartFetched = false;
  get cartFetched => _cartFetched;
  set cartFetched(value) {
    _cartFetched = value;
    notifyListeners();
  }

  // delivery methods
  List<ShippingPlan> shippingPlans = [];

  bool _shippingPlansFetched = false;
  get shippingPlansFetched => _shippingPlansFetched;
  set shippingPlansFetched(value) {
    _shippingPlansFetched = value;
    notifyListeners();
  }

  bool _isMakePaymentInProgress = false;
  get isMakePaymentInProgress => _isMakePaymentInProgress;
  set isMakePaymentInProgress(value) {
    _isMakePaymentInProgress = value;
    notifyListeners();
  }

  int _currentShippingPlan = 0;
  get currentShippingPlan => _currentShippingPlan;
  set currentShippingPlan(value) {
    _currentShippingPlan = value;
    notifyListeners();
  }

  // delivery calculations
  get deliveryAmount =>
      shippingPlans.length == 0 ? 0 : shippingPlans[currentShippingPlan].price;
  get orderAmount =>
      cartproducts.fold(0, (acc, curr) => acc + curr.price * curr.quantity);
  get totalAmount => deliveryAmount + orderAmount;

  // shipping addresses
  int _currentShippingAddress = 0;
  get currentShippingAddress => _currentShippingAddress;
  set currentShippingAddress(value) {
    _currentShippingAddress = value;
    notifyListeners();
  }

  // model ready
  get modelReady => cartFetched && shippingPlansFetched;

  // METHODS

  setUpModel() {
    fetchCart();
    fetchShippingPlans();
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

  fetchShippingPlans() async {
    try {
      shippingPlans = await _firestoreService.getDataCollection<ShippingPlan>(
        path: "shipping_plans",
        builder: ({
          Map<String, dynamic> data,
          String documentID,
          DocumentSnapshot snapshot,
        }) =>
            ShippingPlan.fromMap(
          data: data,
          documentId: documentID,
        ),
      );
      shippingPlansFetched = true;
    } catch (e) {
      print(e);
    }
  }

  makePayment(List<ShippingAddressModel> shippingAddresses) async {
    _overlayService.showLoadingDialog();
    await Future.delayed(Duration(seconds: 5));
    await _overlayService.hideLoadingDialog();
    return;
    if (isValid && !isMakePaymentInProgress) {
      isMakePaymentInProgress = true;
      Map<String, dynamic> payload = {};

      // set shipping plan and shipping address
      payload["shipping_plan"] = shippingPlans[currentShippingPlan].name;
      payload["shipping_address"] =
          shippingAddresses[currentShippingAddress].title;

      // set payment info
      final cp = currentPaymentMethod;
      if (cp == PaymentMethod.AirtelTigoMoney ||
          cp == PaymentMethod.MtnMobileMoney ||
          cp == PaymentMethod.VodafoneCash) {
        payload["payment_method"] = "mobile_money";
        payload["phone_number"] = phoneNumber.formz.value;
      } else {
        payload["payment_method"] = "card";
        payload["card_number"] = cardNumber.formz.value;
        payload["card_month"] = cardMonth.formz.value;
        payload["card_year"] = cardYear.formz.value;
        payload["card_cvv"] = cardCvv.formz.value;
      }

      if (cp == PaymentMethod.VodafoneCash) {
        payload["network"] = "vodafone";
        payload["voucher"] = voucher.formz.value;
      }

      if (cp == PaymentMethod.AirtelTigoMoney) {
        payload["network"] = "airteltigo";
      }

      if (cp == PaymentMethod.MtnMobileMoney) {
        payload["network"] = "mtn";
      }

      try {
        final data = await _cloudFunctionService.call(
          name: "makePayment",
          data: payload,
        );

        // subscribe to orderReference
        orderSubscription = _firestoreService
            .documentStream<OrderModel>(
          path: "orders/${data['data']['orderReference']}",
          builder: (data, documentId) =>
              OrderModel.fromMap(data: data, documentId: documentId),
        )
            .listen((order) {
          if (order.transactionStatus) {
            // hide modal
            hideLoadingModal();
            // unsubscribe
            orderSubscription.cancel();
            // redirect to orders page
            _navigationService.navigateTo("Orders");
          }
        });

        // success
        if (data["code"] == 2000) {
          // ask user to be redirected
          if (data["data"]["redirect"]) {
            // ask user before you redirect
          } else {
            // show instructions and show loading
            await _overlayService.showOkayDialog(secondary: data["message"]);
            await _overlayService.showLoadingDialog();
          }
        }
      } on PlatformException catch (e) {
        _overlayService.showSnackBarFailure(
            widget: Text("Something wrong happened."));
      }

      isMakePaymentInProgress = false;
    }
  }

  hideLoadingModal() {
    // hiding payment dialog
  }

  launchRedirectUrl(url) {}

  @override
  void dispose() {
    cartSubscription.cancel();
    super.dispose();
  }
}
