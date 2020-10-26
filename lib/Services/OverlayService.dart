import 'dart:async';

import 'package:flutter/material.dart';

class OverlayService {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // YES NO DIALOG
  Completer<bool> yesNoDialogCompleter;
  Function yesNoDialogCallback;
  void registerYesNoDialogCallback(Function callback) {
    yesNoDialogCallback = callback;
  }

  showYesNoDialog() {
    yesNoDialogCompleter = Completer<bool>();
    yesNoDialogCallback();
    return yesNoDialogCompleter.future;
  }

  // SHOW LOADING DIALOG
  Completer<bool> showLoadingDialogCompleter;
  Function showLoadingDialogCallback;
  void registerLoadingDialogCallback(Function callback) {
    showLoadingDialogCallback = callback;
  }

  showLoadingDialog() {
    showLoadingDialogCompleter = Completer<bool>();
    showLoadingDialogCallback();
    return showLoadingDialogCompleter.future;
  }

  // SHOW PAYMENT DIALOG
  Completer<bool> showPaymentDialogCompleter;
  Function showPaymentDialogCallback;
  void registerPaymentDialogCallback(Function callback) {
    showPaymentDialogCallback = callback;
  }

  showPaymentDialog() {
    showPaymentDialogCompleter = Completer<bool>();
    showPaymentDialogCallback();
    return showPaymentDialogCompleter.future;
  }
}
