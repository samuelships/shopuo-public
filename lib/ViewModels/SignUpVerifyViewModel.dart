import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shopuo/Services/CloudFunctionService.dart';
import 'package:shopuo/Services/NavigationService.dart';
import 'package:shopuo/Services/OverlayService.dart';

import '../locator.dart';

class SignUpVerifyViewModel with ChangeNotifier {
  // services
  final _navigationService = locator<NavigationService>();
  final _cloudFunctionService = locator<CloudFunctionService>();
  final _overlayService = locator<OverlayService>();

  // page data
  int timeToSend = 0;

  bool _isTimeToSend = true;
  get isTimeToSend => _isTimeToSend;
  set isTimeToSend(value) {
    _isTimeToSend = value;
    notifyListeners();
  }

  bool _isVerifyPhoneNumberInProgress = false;
  get isVerifyPhoneNumberInProgress => _isVerifyPhoneNumberInProgress;
  set isVerifyPhoneNumberInProgress(value) {
    _isVerifyPhoneNumberInProgress = value;
    notifyListeners();
  }

  bool codeSent = false;

  // methods
  setUp() {
    sendVerificationCode();
  }

  resendCode() {
    sendVerificationCode();
  }

  verifyPhoneNumber(code) async {
    if (!isVerifyPhoneNumberInProgress) {
      isVerifyPhoneNumberInProgress = true;
      try {
        var data = await _cloudFunctionService
            .call(name: "verifyPhoneNumber", data: {"code": code});

        // success
        if (data["code"] == 2000) {
          _overlayService.showSnackBarSuccess(widget: Text(data["message"]));
          notifyListeners();

          _navigationService.navigateToAndClear("OnSale");
        } else {
          _overlayService.showSnackBarFailure(widget: Text(data["message"]));
        }
      } on PlatformException catch (e) {
        _overlayService.showSnackBarFailure(
            widget: Text("Something wrong happened."));
      } finally {
        isVerifyPhoneNumberInProgress = false;
      }
    }
  }

  sendVerificationCode() async {
    try {
      var data = await _cloudFunctionService.call(
        name: "sendVerificationCode",
      );

      // success
      if (data["code"] == 2000) {
        _overlayService.showSnackBarSuccess(widget: Text(data["message"]));
        timeToSend = data["data"]["time_to_send"];
        isTimeToSend = false;
        codeSent = true;
        notifyListeners();
      }
    } on PlatformException catch (e) {
      _overlayService.showSnackBarFailure(
          widget: Text("Something wrong happened."));
    } finally {}
  }
}
