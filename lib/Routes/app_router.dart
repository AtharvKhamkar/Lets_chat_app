import 'package:get/get_navigation/get_navigation.dart';
import 'package:lets_chat/screens/home_page.dart';

class AppRouter {
  AppRouter._();
  static const initial = '/home-screen';
  static final routes = [
    GetPage(name: '/home-screen', page: () => const HomePage())
  ];
}
