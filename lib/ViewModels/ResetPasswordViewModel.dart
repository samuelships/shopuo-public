import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:shopuo/Services/AuthenticationService.dart';
import 'package:shopuo/Services/OverlayService.dart';
import 'package:shopuo/Validators/EmailValidator.dart';
import 'package:shopuo/Validators/FormValidator.dart';

import '../locator.dart';

class ResetPasswordViewModel with ChangeNotifier {
  // services
  final _authenticationService = locator<AuthenticationService>();
  final _overlayService = locator<OverlayService>();

  // validation
  FormValidator email = FormValidator(validators: emailValidators);

  get isValid {
    final inputs = <FormzInput>[email.formz];
    return Formz.validate(inputs) == FormzStatus.valid ? true : false;
  }

  // other variables
  bool _resetPasswordInProgress = false;
  get resetPasswordInProgress => _resetPasswordInProgress;
  set resetPasswordInProgress(progress) {
    _resetPasswordInProgress = progress;
    notifyListeners();
  }

  sendResetPasswordLink() async {
    if (isValid && !resetPasswordInProgress) {
      resetPasswordInProgress = true;

      try {
        await _authenticationService.sendPasswordResetEmail(email.formz.value);

        _overlayService.showSnackBarSuccess(
          widget: Text("Reset Email sent successfully"),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == "user-not-found") {
          email.localError = "Email not found";
        }
      } finally {
        resetPasswordInProgress = false;
      }
    }
  }
}
