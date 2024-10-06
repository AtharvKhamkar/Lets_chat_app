import 'package:get/get.dart';

class AppValidatorUtil {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter email ID';
    } else if (value.isEmail == false) {
      return 'Please enter a valid email ID';
    }
    return null;
  }

  static String? validateEmpty({String? value, required String message}) {
    if (value == null || value.isEmpty) {
      return 'Please enter your $message';
    }
    return null;
  }

  // Username validation: must be lowercase letters only
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a username';
    } else if (!RegExp(r'^[a-z]+$').hasMatch(value)) {
      return 'Username must be in lowercase letters only';
    }
    return null;
  }
}
