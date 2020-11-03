import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shopuo/OverlayManager.dart';
import 'package:shopuo/Router.dart';
import 'package:shopuo/Screens/EntryPoint.dart';
import 'package:shopuo/Screens/SignUpInfo.dart';
import 'package:shopuo/Screens/SignUpVerify.dart';
import 'package:shopuo/Services/NavigationService.dart';
import 'package:shopuo/ViewModels/CartViewModel.dart';
import 'package:shopuo/ViewModels/CategoriesViewModel.dart';
import 'package:shopuo/ViewModels/OnSaleViewModel.dart';
import 'package:shopuo/ViewModels/SettingsViewModel.dart';
import 'package:shopuo/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<OnSaleViewModel>(
          create: (_) => locator<OnSaleViewModel>(),
        ),
        ChangeNotifierProvider<CategoriesViewModel>(
          create: (_) => locator<CategoriesViewModel>(),
        ),
        ChangeNotifierProvider<CartViewModel>(
          create: (_) => locator<CartViewModel>(),
        ),
        ChangeNotifierProvider<SettingsViewModel>(
          create: (_) => locator<SettingsViewModel>(),
        )
      ],
      builder: (_, __) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(scaffoldBackgroundColor: Colors.white),
        title: 'Shopuo',
        builder: (BuildContext context, Widget child) => OverlayManager.create(
          child: child,
        ),
        home: EntryPoint.create(),
        onGenerateRoute: generateRoute,
        navigatorKey: locator<NavigationService>().navigatorKey,
      ),
    );
  }
}
