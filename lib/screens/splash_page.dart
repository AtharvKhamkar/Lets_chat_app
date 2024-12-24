import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get_it/get_it.dart';
import 'package:lets_chat/controller/auth_controller.dart';
import 'package:lets_chat/screens/login_page.dart';
import 'package:lets_chat/services/local_auth_service.dart';
import 'package:lets_chat/services/shared_preference_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final GetIt _getIt = GetIt.instance;
  final AuthController authController =
      AuthController().initialized ? Get.find() : Get.put(AuthController());
  late SharedPreferenceService _sharedPref;
  String? email;
  String? password;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    decideEntryScreen();
  }

  Future<void> decideEntryScreen() async {
    try {
      Future.delayed(const Duration(seconds: 3), () async {
        await loadUserCredentials();
      });
    } catch (e) {
      debugPrint('Error in the decideEntryScreen function $e');
    }
  }

  Future<void> loadUserCredentials() async {
    try {
      if (await LocalAuthService.service.authenticationProcess()) {
        _sharedPref = await _getIt.getAsync<SharedPreferenceService>();
        if (await _sharedPref.isLoggedIn()) {
          final checkLogginStatus = await _sharedPref.isLoggedIn();
          debugPrint(
              'Result of the previous login status is $checkLogginStatus');
          debugPrint(
              'fetching saved email :: ${_sharedPref.prefs?.getString(SharedPreferenceService.emailKey)}');
          debugPrint(
              'fetching saved password :: ${_sharedPref.prefs?.getString(SharedPreferenceService.passwordKey)}');
          email =
              _sharedPref.prefs?.getString(SharedPreferenceService.emailKey);
          password =
              _sharedPref.prefs?.getString(SharedPreferenceService.passwordKey);
          debugPrint('Obtained email and password is $email and $password');
          if (email!.isNotEmpty && password!.isNotEmpty) {
            authController.emailController.text = email ?? '';
            authController.passwordController.text = password ?? '';
            authController.login();
          } else {
            Get.offAll(() => const LoginPage(), binding: AuthBinding());
          }
        } else {
          Get.offAll(() => const LoginPage(), binding: AuthBinding());
        }
      } else {
        Get.offAll(() => const LoginPage(), binding: AuthBinding());
      }
    } catch (e) {
      debugPrint('Error in the loadUserCredentials function $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            const Spacer(),
            SizedBox(
              height: Get.height * 0.5,
              width: Get.width * 0.5,
              child:
                  Image.asset('assets/Images/messenger.png').animate().fadeIn(),
            ),
            SizedBox(
              height: Get.height * 0.1,
            ),
            const Spacer(),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
