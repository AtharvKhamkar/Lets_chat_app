import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';
import 'package:local_auth/error_codes.dart' as local_auth_error;

class LocalAuthService {
  LocalAuthService._();

  static final LocalAuthService _instance = LocalAuthService._();

  static Future<LocalAuthService> getInstance() async {
    LocalAuthService instance = LocalAuthService._();
    instance = await LocalAuthService.getInstance();
    return instance;
  }

  static LocalAuthService get service => _instance;

  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> isBiometricsSupported() async {
    final bool isSupported =
        await auth.canCheckBiometrics || await auth.isDeviceSupported();
    return isSupported;
  }

  Future<bool> authenticationProcess() async {
    try {
      bool didAuthenticate = false;
      final bool isSupported = await isBiometricsSupported();
      if (isSupported == true) {
        didAuthenticate = await auth.authenticate(
          localizedReason: 'Please authenticate to proceed further',
          options: const AuthenticationOptions(
              biometricOnly: false,
              useErrorDialogs: true,
              stickyAuth: true,
              sensitiveTransaction: true),
          authMessages: const <AuthMessages>[
            AndroidAuthMessages(
                signInTitle: 'Biometrics is required!!',
                cancelButton: 'No thanks'),
            IOSAuthMessages(cancelButton: 'No thanks'),
          ],
        );
      }
      return didAuthenticate;
    } on PlatformException catch (e) {
      if (e.code == local_auth_error.notAvailable) {
        Get.snackbar('Error', 'Biometrics are not available');
      }
    }
    return false;
  }
}
