import 'package:get_it/get_it.dart';
import 'package:sugar_client/router/deprecated_nav/navigation_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
}