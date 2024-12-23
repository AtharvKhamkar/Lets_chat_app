import 'package:get/get_navigation/get_navigation.dart';
import 'package:lets_chat/controller/auth_controller.dart';
import 'package:lets_chat/screens/home_page.dart';
import 'package:lets_chat/screens/login_page.dart';
import 'package:lets_chat/screens/registration_page.dart';
import 'package:lets_chat/screens/splash_page.dart';

class AppRouter {
  AppRouter._();
  static const initial = '/splash-screen';
  static final routes = [
    GetPage(
        name: '/splash-screen',
        page: () => const SplashPage(),
        binding: AuthBinding()),
    GetPage(
        name: '/home-screen',
        page: () => const HomePage(),
        binding: AuthBinding()),
    GetPage(
        name: '/registration',
        page: () => const RegistrationPage(),
        binding: AuthBinding()),
    GetPage(
        name: '/login', page: () => const LoginPage(), binding: AuthBinding()),
  ];
}
