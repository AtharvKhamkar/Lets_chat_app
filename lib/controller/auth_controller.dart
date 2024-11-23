import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:lets_chat/modals/user_details_model.dart';
import 'package:lets_chat/repository/auth_repository.dart';
import 'package:lets_chat/services/shared_preference_service.dart';

class AuthController extends GetxController with StateMixin<dynamic> {
  final _authRepo = AuthRepository();
  final GetIt _getIt = GetIt.instance;
  late SharedPreferenceService _sharedPref;

  var profile = UserDetailsModel(
          id: '12345',
          username: 'sampleusername',
          email: 'sample@gmail.com',
          createdAt: '2024-10-28',
          updatedAt: '2024-10-28',
          v: 1)
      .obs;

  //TextEditingControllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  //Booleans
  var isLoading = false.obs;
  var hasData = false.obs;

  //Strings
  var errorMessage = "".obs;
  var errorEmailMessage = "".obs;
  var errorUsernameMessage = "".obs;
  var errorPasswordMessage = "".obs;

  @override
  void onInit() async {
    super.onInit();
    if (kDebugMode) {
      usernameController.text = "";
      emailController.text = "";
      passwordController.text = "";
    }
    await initializeSharedPreferences();
    if (_sharedPref.prefs == null) {
      debugPrint('Shared preference is not initalized in the AuthController');
    }
  }

  Future<void> initializeSharedPreferences() async {
    _sharedPref = await _getIt.getAsync<SharedPreferenceService>();
  }

  void register() async {
    if (isLoading.value) return;
    isLoading(true);
    update();

    final result = await _authRepo.registerUser(
        usernameController.text, emailController.text, passwordController.text);

    debugPrint('Result of the registration process :: ${result}');

    if (result != null) {
      profile(result);
      update();
      reset();
      Get.offAllNamed('/login');
    } else {
      Get.snackbar(
          'Registration process failed', 'Please try again after some time');
    }
    isLoading(false);
    update();
  }

  Future<void> login() async {
    if (isLoading.value) return;
    isLoading(true);
    update();

    final result = await _authRepo.loginUser(
        emailController.text, passwordController.text);

    if (result != null) {
      profile(result);
      bool isPrefProcessSuccess = await _sharedPref.saveUserCredentials(
          emailController.text, passwordController.text, profile.value.id!);

      update();
      // reset();
      Get.offAllNamed('/home-screen');
    } else {
      Get.snackbar('Login process failed', 'Please try again after some time');
    }
    isLoading(false);
    update();
  }

  void reset() {
    usernameController.clear();
    emailController.clear();
    passwordController.clear();
  }
}

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(
      () => AuthController(),
      fenix: true,
    );
  }
}
