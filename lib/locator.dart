import 'package:get_it/get_it.dart';
import 'services/navigationService.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  try {
    locator.registerLazySingleton(() => NavigationService());
  } catch (e) {
    print(e);
  }
  
}