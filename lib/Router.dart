import 'package:flutter/material.dart';
import 'package:shopuo/Screens/SignIn.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case "Signin":
      return getPageRoute(
        builder: SignIn(),
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
    builder: builder,
    settings: RouteSettings(name: name, arguments: arguments),
  );
}
