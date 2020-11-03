import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopuo/Services/AuthenticationService.dart';
import 'package:shopuo/Services/NavigationService.dart';

import '../locator.dart';

class ProfileViewModel with ChangeNotifier {
  // services
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();

  // page data
  List<Map> sections = [
    {"heading": "Tiana Rosser", "sub heading": "Full name"},
    {"heading": "Tanamojo@gmail.com", "sub heading": "Email address"},
  ];

  // other variables

  // getters and setters

  // methods
  setUpModel() {
    User data = _authenticationService.currentUser();
    print(data.providerData);
  }

  logOut() async {
    await _authenticationService.logout();
    await _navigationService.navigateToAndClear("SignIn");
  }

  goToProfile() async {
    await _navigationService.navigateInner("Profile");
  }
}
