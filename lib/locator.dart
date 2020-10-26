import 'package:get_it/get_it.dart';
import 'package:shopuo/Services/AuthenticationService.dart';
import 'package:shopuo/Services/NavigationService.dart';
import 'package:shopuo/Services/OverlayService.dart';
import 'package:shopuo/ViewModels/EntryPointViewModel.dart';
import './Services/FirebaseMessagingService.dart';
import 'ViewModels/OverlayManagerViewModel.dart';

final locator = GetIt.instance;

setupLocator() {
  locator.registerFactory(() => OverlayManagerViewModel());
  locator.registerFactory(() => EntryPointViewModel());

  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => OverlayService());
  locator.registerLazySingleton(() => FirebaseMessagingService());
}
