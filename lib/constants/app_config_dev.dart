import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:lets_chat/constants/app_config.dart';

class AppConfigDev implements AppConfig {
  @override
  String get BASE_CHAT_URL {
    if (kIsWeb) {
      return 'http://localhost:2525';
    } else if (Platform.isAndroid) {
      return 'ws://10.0.2.2:2525';
    } else if (Platform.isIOS) {
      return 'ws://127.0.0.1:2525';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  @override
  String get BASE_URL {
    if (kIsWeb) {
      return 'http://localhost:2525/v1/';
    } else if (Platform.isAndroid) {
      return 'http://10.0.2.2:2525/v1/';
    } else if (Platform.isIOS) {
      return 'http://127.0.0.1:2525/v1/';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  @override
  String get BASE_GOOGLE_MAPS_URL => 'https://maps.googleapis.com/maps/api';
}
