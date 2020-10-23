import 'package:flutter/material.dart';
import 'package:shopuo/Screens/Address.dart';
import 'package:shopuo/Screens/Categories.dart';
import 'package:shopuo/Screens/ChangeEmail.dart';
import 'package:shopuo/Screens/ChangeName.dart';
import 'package:shopuo/Screens/ChangePassword.dart';
import 'package:shopuo/Screens/Congratulations.dart';
import 'package:shopuo/Screens/EditAddress.dart';
import 'package:shopuo/Screens/OnSale.dart';
import 'package:shopuo/Screens/Orders.dart';
import 'package:shopuo/Screens/PrivacyPolicy.dart';
import 'package:shopuo/Screens/ProductDetails.dart';
import 'package:shopuo/Screens/Profile.dart';
import 'package:shopuo/Screens/PushNotification.dart';
import 'package:shopuo/Screens/ResetPassword.dart';
import 'package:shopuo/Screens/Search.dart';
import 'package:shopuo/Screens/Settings.dart';
import 'package:shopuo/Screens/SignIn.dart';
import 'package:shopuo/Screens/SignUp.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      title: 'Shopuo',
      home: SignUp(),
    );
  }
}
