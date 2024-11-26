import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lets_chat/Routes/app_router.dart';
import 'package:lets_chat/controller/auth_controller.dart';
import 'package:lets_chat/utils/colors.dart';
import 'package:lets_chat/utils/register_services.dart';
import 'package:lets_chat/widgets/custom_toast_util.dart';
import 'package:overlay_support/overlay_support.dart';

void main() async {
  await registerServices();
  runApp(const OverlaySupport.global(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    CustomToastUtil.init(context);
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
