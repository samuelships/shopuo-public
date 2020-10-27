import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:formz/formz.dart';
import 'package:shopuo/Services/AuthenticationService.dart';
import 'package:shopuo/Services/NavigationService.dart';
import 'package:shopuo/Validators/EmailValidator.dart';
import 'package:shopuo/Validators/FormValidator.dart';
import 'package:shopuo/Validators/PasswordValidator.dart';

import '../locator.dart';

class SignInViewModel with ChangeNotifier {
  // services
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();

  // validation
  FormValidator password = FormValidator(validators: passwordValidators);
  FormValidator email = FormValidator(validators: emailValidators);

  get isValid {
    final inputs = <FormzInput>[email.formz, password.formz];
    return Formz.validate(inputs) == FormzStatus.valid ? true : false;
  }

  // other variables
  bool _signInInProgress = false;
  get signInInProgress => _signInInProgress;
  set signInInProgress(progress) {
    _signInInProgress = progress;
    notifyListeners();
  }

  // methods
  goToSignUp() async {
    await _navigationService.navigateTo("SignUp");
  }

  goToResetPassword() async {
    await _navigationService.navigateTo("ResetPassword");
  }

  signInWithEmailAndPassword() async {
    if (isValid && !signInInProgress) {
      signInInProgress = true;

      // signup
      try {
        await _authenticationService.signInWithEmailAndPassword(
          email: email.formz.value,
          password: password.formz.value,
        );

        //await _navigationService.navigateToAndClear("Home");
      } on FirebaseAuthException catch (error) {
        if (error.code == "invalid-email") {
          email.localError = "Email is invalid";
        }

        if (error.code == "user-disabled") {
          email.localError = "User has been disabled";
        }

        if (error.code == "user-not-found") {
          email.localError = "User not found";
        }

        if (error.code == "wrong-password") {
          password.localError = "Password is incorrect";
        }

        notifyListeners();
      } finally {
        signInInProgress = false;
      }
    }
  }

  continueWithGoogle() async {
    await _authenticationService.signInWithGoogle();
  }
}
