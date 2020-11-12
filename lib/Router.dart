import 'package:flutter/material.dart';
import 'package:shopuo/Screens/Address.dart';
import 'package:shopuo/Screens/Categories.dart';
import 'package:shopuo/Screens/ChangeEmail.dart';
import 'package:shopuo/Screens/ChangeName.dart';
import 'package:shopuo/Screens/ChangePassword.dart';
import 'package:shopuo/Screens/EditAddress.dart';
import 'package:shopuo/Screens/NestedNavigagtion.dart';
import 'package:shopuo/Screens/Orders.dart';
import 'package:shopuo/Screens/PrivacyPolicy.dart';
import 'package:shopuo/Screens/ProductDetails.dart';
import 'package:shopuo/Screens/Profile.dart';
import 'package:shopuo/Screens/PushNotification.dart';
import 'package:shopuo/Screens/ResetPassword.dart';
import 'package:shopuo/Screens/Settings.dart';
import 'package:shopuo/Screens/SignIn.dart';
import 'package:shopuo/Screens/SignUp.dart';
import 'package:shopuo/Screens/SignUpInfo.dart';
import 'package:shopuo/Screens/SignUpVerify.dart';

import 'Screens/Cart.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case "SignIn":
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

    case "OnSale":
      return getPageRoute(
        builder: NestedNavigation(),
        name: settings.name,
        arguments: settings.arguments,
      );
      break;

    case "Categories":
      return getPageRoute(
        builder: Categories(),
        name: settings.name,
        arguments: settings.arguments,
      );
      break;

    case "Cart":
      return getPageRoute(
        builder: Cart(),
        name: settings.name,
        arguments: settings.arguments,
      );
      break;

    case "Profile":
      return getPageRoute(
        builder: Profile(),
        name: settings.name,
        arguments: settings.arguments,
      );
      break;

    case "Settings":
      return getPageRoute(
        builder: Settings(),
        name: settings.name,
        arguments: settings.arguments,
      );
      break;

    case "SignUpInfo":
      return getPageRoute(
        builder: SignUpInfo.create(),
        name: settings.name,
        arguments: settings.arguments,
      );
      break;

    case "SignUpVerify":
      var args = settings.arguments as Map;
      return getPageRoute(
        builder: SignUpVerify.create(phoneNumber: args["phone_number"]),
        name: settings.name,
        arguments: settings.arguments,
      );
      break;

    case "ChangeName":
      return getPageRoute(
        builder: ChangeName(),
        name: settings.name,
        arguments: settings.arguments,
      );
      break;

    case "ChangeEmail":
      return getPageRoute(
        builder: ChangeEmail(),
        name: settings.name,
        arguments: settings.arguments,
      );
      break;

    case "ChangePassword":
      return getPageRoute(
        builder: ChangePassword(),
        name: settings.name,
        arguments: settings.arguments,
      );
      break;

    case "Address":
      return getPageRoute(
        builder: Address(),
        name: settings.name,
        arguments: settings.arguments,
      );
      break;

    case "AddAddress":
      var args = settings.arguments as Map;
      EditAddress builder;

      if (args != null) {
        builder = EditAddress(
          id: args["id"],
          title: args["title"],
          description: args["description"],
        );
      } else {
        builder = EditAddress();
      }

      return getPageRoute(
        builder: builder,
        name: settings.name,
        arguments: settings.arguments,
      );
      break;

    case "PushNotification":
      return getPageRoute(
        builder: PushNotification(),
        name: settings.name,
        arguments: settings.arguments,
      );
      break;

    case "PrivacyPolicy":
      return getPageRoute(
        builder: PrivacyPolicy(),
        name: settings.name,
        arguments: settings.arguments,
      );
      break;

    case "ProductDetails":
      var args = settings.arguments as Map;
      return getPageRoute(
        builder: ProductDetails.create(product: args["product"]),
        name: settings.name,
        arguments: settings.arguments,
      );
      break;

    case "Orders":
      print("navigation to orders..");
      return getPageRoute(
        builder: Orders.create(),
        name: settings.name,
        arguments: settings.arguments,
      );
      break;

    default:
      return getPageRoute(
        builder: SignIn.create(),
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
