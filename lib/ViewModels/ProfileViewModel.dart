import 'package:flutter/cupertino.dart';
import 'package:shopuo/Services/AuthenticationService.dart';
import 'package:shopuo/Services/FirestoreService.dart';
import 'package:shopuo/Services/NavigationService.dart';

import '../locator.dart';

class ProfileViewModel with ChangeNotifier {
  // services
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();
  final _firestoreService = locator<FirestoreService>();

  // page data
  String fullName = "";
  String email = "";
  String profile = "https://uifaces.co/our-content/donated/KtCFjlD4.jpg";

  List<Map> sections = [
    {"heading": "Tiana Rosser", "sub heading": "Full name"},
  ];

  // methods
  setUpModel() async {
    final userId = _authenticationService.currentUser().uid;
    final userSnapshot = await _firestoreService.getData("user_info/$userId");
    sections[0]["heading"] = userSnapshot.data()["full_name"];
    fullName = userSnapshot.data()["full_name"];
    profile = userSnapshot.data()["profile_photo"];

    // check if email can be updated
    final userInfo = _authenticationService.currentUser().providerData[0];
    email = userInfo.email;
    if (userInfo.providerId != "google.com") {
      sections.add(
        {"heading": userInfo.email, "sub heading": "Email address"},
      );
    }
    notifyListeners();
  }

  logOut() async {
    await _authenticationService.logout();
    await _navigationService.navigateToAndClear("SignIn");
  }

  goToProfile() async {
    await _navigationService.navigateInner("Profile");
  }
}
