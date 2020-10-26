import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shopuo/OverlayManager.dart';
import 'package:shopuo/Router.dart';
import 'package:shopuo/Screens/EntryPoint.dart';
import 'package:shopuo/Services/NavigationService.dart';
import 'package:shopuo/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      title: 'Shopuo',
      builder: (BuildContext context, Widget child) =>
          OverlayManager.create(child: child),
      home: EntryPoint.create(),
      onGenerateRoute: generateRoute,
      navigatorKey: locator<NavigationService>().navigatorKey,
    );
  }
}
