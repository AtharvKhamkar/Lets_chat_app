import 'package:get_it/get_it.dart';
import 'package:lets_chat/constants/app_config.dart';
import 'package:lets_chat/constants/app_config_dev.dart';
import 'package:lets_chat/constants/app_config_prod.dart';
import 'package:lets_chat/flavors.dart';
import 'package:lets_chat/main_prod.dart';
import 'package:lets_chat/services/api_client_service.dart';

void setupLocator() {
  if (F.appFlavor == Flavor.dev) {
    getIt.registerLazySingleton<AppConfig>(() => AppConfigDev());
  } else {
    getIt.registerLazySingleton<AppConfig>(() => AppConfigProd());
  }

  getIt.registerLazySingleton<ApiClientService>(() => ApiClientService());
}
