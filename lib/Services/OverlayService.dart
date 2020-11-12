import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shopuo/Styles/Color.dart';

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
  Function hideLoadingDialogCallback;
  void registerLoadingDialogCallback(Function callback) {
    showLoadingDialogCallback = callback;
  }

  void registerHideLoadingDialogCallback(Function callback) {
    hideLoadingDialogCallback = callback;
  }

  showLoadingDialog() {
    showLoadingDialogCompleter = Completer<bool>();
    showLoadingDialogCallback();
    return showLoadingDialogCompleter.future;
  }

  hideLoadingDialog() {
    hideLoadingDialogCallback();
  }

  // SHOW OKAY DIALOG
  Completer<bool> showOkayDialogCompleter;
  Function showOkayDialogCallback;
  void registerOkayDialogCallback(Function callback) {
    showOkayDialogCallback = callback;
  }

  showOkayDialog({icon, primary, secondary}) {
    showOkayDialogCompleter = Completer<bool>();
    showOkayDialogCallback(icon: icon, primary: primary, secondary: secondary);
    return showOkayDialogCompleter.future;
  }

  // SNACKBAR NOTIFICATIONS
  showSnackBarSuccess({Widget widget}) {
    scaffoldKey.currentState.hideCurrentSnackBar();
    scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: widget,
        backgroundColor: MyColor.primaryGreen,
      ),
    );
  }

  showSnackBarFailure({Widget widget}) {
    scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: widget,
        backgroundColor: MyColor.primaryRed,
      ),
    );
  }
}
