import 'package:flutter/material.dart';
import 'package:lets_chat/injection/locator.dart';
import 'package:lets_chat/utils/register_services.dart';

import 'flavors.dart';

import 'main.dart' as runner;

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await F.setAppFlavor(Flavor.dev);
    registerServices();
    setupLocator();
    await runner.main();
  } catch (e, s) {
    debugPrint("error in main_dev  :$e ,$s");
  }
}
