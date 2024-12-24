import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lets_chat/Routes/app_router.dart';
import 'package:lets_chat/controller/auth_controller.dart';
import 'package:lets_chat/utils/colors.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.primaryColor,
        appBarTheme: const AppBarTheme(color: AppColors.primaryColor),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: AppRouter.initial,
      getPages: AppRouter.routes,
      initialBinding: AuthBinding(),
    );
  }
}
