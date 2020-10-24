import 'package:get_it/get_it.dart';
import 'package:shopuo/Services/NavigationService.dart';
import 'package:shopuo/Services/OverlayService.dart';
import './Services/FirebaseMessagingService.dart';
import 'ViewModels/OverlayManagerViewModel.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerFactory(() => OverlayManagerViewModel());

  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => OverlayService());
  locator.registerLazySingleton(() => FirebaseMessagingService());
}
