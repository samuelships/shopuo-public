import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopuo/Services/AuthenticationService.dart';
import 'package:shopuo/Services/NavigationService.dart';
import 'package:shopuo/Validators/EmailValidator.dart';
import 'package:shopuo/Validators/FormValidator.dart';
import 'package:shopuo/Validators/PasswordValidator.dart';

import '../locator.dart';

class SignUpViewModel with ChangeNotifier {
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
  bool _signUpInProgress = false;
  get signUpInProgress => _signUpInProgress;
  set signUpInProgress(progress) {
    _signUpInProgress = progress;
    notifyListeners();
  }

  // methods

  goToResetPassword() async {
    await _navigationService.navigateTo("ResetPassword");
  }

  signUpWithEmailAndPassword() async {
    if (isValid && !signUpInProgress) {
      signUpInProgress = true;

      // signup
      try {
        await _authenticationService.signUpWithEmailAndPassword(
          email: email.formz.value,
          password: password.formz.value,
        );

        //await _navigationService.navigateToAndClear("Home");
      } on FirebaseAuthException catch (error) {
        if (error.code == "invalid-email") {
          email.localError = "Email is invalid";
        }

        if (error.code == "weak-password") {
          password.localError = "Password is weak";
        }

        if (error.code == "email-already-in-use") {
          email.localError = "Email is already in use";
        }

        notifyListeners();
      } finally {
        signUpInProgress = false;
      }
    }
  }

  continueWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
