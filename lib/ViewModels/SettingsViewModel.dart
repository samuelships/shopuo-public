import 'package:flutter/cupertino.dart';
import 'package:shopuo/Services/AuthenticationService.dart';
import 'package:shopuo/Services/NavigationService.dart';

import '../locator.dart';

class SettingsViewModel with ChangeNotifier {
  // services
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();

  // page data

  // other variables

  // getters and setters

  // methods
  logOut() async {
    await _authenticationService.logout();
    await _navigationService.navigateToAndClear("SignIn");
  }
}
