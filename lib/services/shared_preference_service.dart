
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  final String SERVICE_NAME = 'SHARED_PREFERENCES_SERVICE';
  SharedPreferences? prefs;

  SharedPreferenceService._();

  static Future<SharedPreferenceService> getInstance() async{
    SharedPreferenceService instance = SharedPreferenceService._();
    instance.prefs = await SharedPreferences.getInstance();
    return instance;
  }

  static const String isLoggedInKey = 'is_logged_in';
  static const String userIdKey = 'user_id';
  static const String userNameKey = 'user_name';
  static const String emailKey = 'email';

  //Function to save user details after the login
  Future<bool> saveUserLoginDetails( String user_name, String email)async{
    const String FUNCTION_NAME = 'SAVE_USER_LOGIN_DETAILS';
    
    try {
      await prefs!.setString(userNameKey, user_name);
      await prefs!.setString(emailKey, email);
      await prefs!.setBool(isLoggedInKey, true);
      return true;
    } catch (e) {
      debugPrint('Error in the $SERVICE_NAME :: $FUNCTION_NAME :: $e');
      return false;
    }
  }

  //Function to check user is logged in or not
  Future<bool> isLoggedIn()async{
    return prefs?.getBool(isLoggedInKey) ?? false;
  }

  //Function to clean all user data
  Future<void> clearUserData() async{
    await prefs!.clear();
  }
}