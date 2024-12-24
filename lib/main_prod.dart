import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lets_chat/injection/locator.dart';
import 'package:lets_chat/utils/register_services.dart';

import 'flavors.dart';

import 'main.dart' as runner;

final GetIt getIt = GetIt.instance;
Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    await F.setAppFlavor(Flavor.prod);
    registerServices();
    setupLocator();
    await runner.main();
  } catch (e, s) {
    debugPrint("error in main_prod  :$e ,$s");
  }
}
