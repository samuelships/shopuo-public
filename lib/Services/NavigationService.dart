import 'package:flutter/cupertino.dart';

class NavigationService {
  GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  void pop() {
    return _navigatorKey.currentState.pop();
  }

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) async {
    return await _navigatorKey.currentState.pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  Future<dynamic> navigateToAndClear(
    String routeName, {
    dynamic arguments,
  }) async {
    return await _navigatorKey.currentState.pushNamedAndRemoveUntil(
      routeName,
      (Route<dynamic> route) => false,
      arguments: arguments,
    );
  }
}
