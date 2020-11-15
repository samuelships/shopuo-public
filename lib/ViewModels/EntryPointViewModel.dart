import 'package:flutter/material.dart';
import 'package:shopuo/Services/AuthenticationService.dart';
import 'package:shopuo/Services/FirestoreService.dart';
import 'package:shopuo/Services/NavigationService.dart';
import 'package:shopuo/locator.dart';

class EntryPointViewModel with ChangeNotifier {
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();
  final _firestoreService = locator<FirestoreService>();

  setUpModel() async {
    // get current user
    final user = _authenticationService.currentUser();
    // user is not logged in
    if (user != null) {
      final docSnapshot =
          await _firestoreService.getData("user_info/${user.uid}");

      // document does not exist
      if (!docSnapshot.exists) {
        return _navigationService.navigateToAndClear("SignUpInfo");
      }

      // if document exists but not verified
      final docSnapshotData = docSnapshot.data();

      if (!docSnapshotData["verified"]) {
        _navigationService.navigateToAndClear("SignUpInfo");
        return _navigationService.navigateTo("SignUpVerify",
            arguments: {"phone_number": docSnapshotData["phone_number"]});
      }

      // if verified
      _navigationService.navigateToAndClear("OnSale");
    } else {
      _navigationService.navigateToAndClear("SignIn");
    }
  }
}
