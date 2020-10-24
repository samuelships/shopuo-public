import 'package:flutter/material.dart';
import 'package:shopuo/OverlayManager.dart';
import 'package:shopuo/Router.dart';
import 'package:shopuo/Screens/SignUp.dart';
import 'package:shopuo/Services/NavigationService.dart';
import 'package:shopuo/locator.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // Open pull request for v1.0.0
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      title: 'Shopuo',
      builder: (BuildContext context, Widget child) => OverlayManager(
        child: child,
      ),
      home: SignUp(),
      onGenerateRoute: generateRoute,
      navigatorKey: locator<NavigationService>().navigatorKey,
    );
  }
}
