import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  final String SERVICE_NAME = 'SHARED_PREFERENCES_SERVICE';
  SharedPreferences? prefs;

  SharedPreferenceService._();

  static Future<SharedPreferenceService> getInstance() async {
    SharedPreferenceService instance = SharedPreferenceService._();
    instance.prefs = await SharedPreferences.getInstance();
    return instance;
  }

  static const String isLoggedInKey = 'is_logged_in';
  static const String userIdKey = 'user_id';
  static const String userNameKey = 'user_name';
  static const String emailKey = 'email';
  static const String passwordKey = 'password';

  //Function to save user details after the login
  Future<bool> saveUserRegistrationDetails(
      String user_name, String email) async {
    const String FUNCTION_NAME = 'SAVE_USER_LOGIN_DETAILS';

    try {
      await clearUserData();
      await prefs!.setString(userNameKey, user_name);
      await prefs!.setString(emailKey, email);
      return true;
    } catch (e) {
      debugPrint('Error in the $SERVICE_NAME :: $FUNCTION_NAME :: $e');
      return false;
    }
  }

  //Function to save user email and password
  Future<bool> saveUserCredentials(
      String email, String password, String userId) async {
    const String FUNCTION_NAME = 'SAVE_USER_CREDENTIALS';
    try {
      // await clearUserData();
      if (prefs == null) {
        debugPrint('pref is not initialized in $FUNCTION_NAME');
        return false;
      }
      await prefs!.setString(userIdKey, userId);
      await prefs!.setString(emailKey, email);
      await prefs!.setString(passwordKey, password);
      await prefs!.setBool(isLoggedInKey, true);
      debugPrint(
          'saved value of userId is ${prefs?.getString(SharedPreferenceService.userIdKey)}');
      debugPrint(
          'saved value of emailKey is ${prefs?.getString(SharedPreferenceService.emailKey)}');
      debugPrint(
          'saved value of password is ${prefs?.getString(SharedPreferenceService.passwordKey)}');
      return true;
    } catch (e) {
      debugPrint('Error in the $SERVICE_NAME :: $FUNCTION_NAME :: $e');
      return false;
    }
  }

  //Function to check user is logged in or not
  Future<bool> isLoggedIn() async {
    return prefs?.getBool(isLoggedInKey) ?? false;
  }

  //Function to clean all user data
  Future<void> clearUserData() async {
    await prefs!.clear();
  }
}
