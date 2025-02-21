import 'package:get/get_navigation/get_navigation.dart';
import 'package:lets_chat/Routes/app_router_constant.dart';
import 'package:lets_chat/controller/auth_controller.dart';
import 'package:lets_chat/controller/location_controller.dart';
import 'package:lets_chat/screens/home_page.dart';
import 'package:lets_chat/screens/location_share_screen.dart';
import 'package:lets_chat/screens/login_page.dart';
import 'package:lets_chat/screens/registration_page.dart';
import 'package:lets_chat/screens/splash_page.dart';

class AppRouter {
  AppRouter._();
  static const initial = AppRouterConstant.kSplashScreen;
  static final routes = [
    GetPage(
        name: AppRouterConstant.kSplashScreen,
        page: () => const SplashPage(),
        binding: AuthBinding()),
    GetPage(
        name: AppRouterConstant.kHomeScreen,
        page: () => const HomePage(),
        binding: AuthBinding()),
    GetPage(
        name: AppRouterConstant.kRegistrationScreen,
        page: () => const RegistrationPage(),
        binding: AuthBinding()),
    GetPage(
        name: AppRouterConstant.kLoginScreen,
        page: () => const LoginPage(),
        binding: AuthBinding()),
    GetPage(
        name: AppRouterConstant.kLocationSharing,
        page: () => const LocationShareScreen(),
        binding: LocationBinding()),
  ];
}
