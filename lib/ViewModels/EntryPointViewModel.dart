import 'package:flutter/material.dart';
import 'package:shopuo/Services/AuthenticationService.dart';
import 'package:shopuo/Services/NavigationService.dart';
import 'package:shopuo/locator.dart';

class EntryPointViewModel with ChangeNotifier {
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();

  setUpModel() async {
    // get current user
    final user = _authenticationService.currentUser();

    // redirect user
    user == null
        ? _navigationService.navigateToAndClear("SigIn")
        : _navigationService.navigateToAndClear("Home");
  }
}
