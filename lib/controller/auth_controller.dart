import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lets_chat/repository/auth_repository.dart';

class AuthController extends GetxController with StateMixin<dynamic>{
  final _authRepo = AuthRepository();
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
  void onInit() {
    if(kDebugMode){
      usernameController.text = "";
      emailController.text = "";
      passwordController.text = "";
    }
    super.onInit();
  }

  void register()async{
    if(isLoading.value) return;
    isLoading(true);
    update();

    final result = await _authRepo.registerUser(usernameController.text, emailController.text, passwordController.text);

    debugPrint('Result of the registration process :: ${result}');

    if(result != null){
      update();
      reset();
      Get.offAllNamed('/home-screen');
    }else{
      Get.snackbar('Registration process failed', 'Please try again after some time');
    }
    isLoading(false);
    update();

  }

  void reset(){
    usernameController.clear();
    emailController.clear();
    passwordController.clear();
  }
}

class AuthBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(
      () => AuthController(),
      fenix: true,
    );
  }
}