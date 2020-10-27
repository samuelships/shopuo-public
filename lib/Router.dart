import 'package:flutter/material.dart';
import 'package:shopuo/Screens/ResetPassword.dart';
import 'package:shopuo/Screens/SignIn.dart';
import 'package:shopuo/Screens/SignUp.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case "SigIn":
      return getPageRoute(
        builder: SignIn.create(),
        name: settings.name,
        arguments: settings.arguments,
      );
      break;

    case "Home":
      return getPageRoute(
        builder: SignIn.create(),
        name: settings.name,
        arguments: settings.arguments,
      );
      break;

    case "SignUp":
      return getPageRoute(
        builder: SignUp.create(),
        name: settings.name,
        arguments: settings.arguments,
      );
      break;

    case "ResetPassword":
      return getPageRoute(
        builder: ResetPassword.create(),
        name: settings.name,
        arguments: settings.arguments,
      );
      break;

    default:
      return getPageRoute(
        builder: SignIn(),
        name: settings.name,
        arguments: settings.arguments,
      );
      break;
  }
}

getPageRoute({builder, name, arguments}) {
  return MaterialPageRoute(
    builder: (_) => builder,
    settings: RouteSettings(name: name, arguments: arguments),
  );
}
