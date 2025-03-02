import 'package:lets_chat/constants/app_config.dart';

class AppConfigProd implements AppConfig {
  @override
  String get BASE_CHAT_URL => 'https://lets-chat-backend-5wa8.onrender.com';

  @override
  String get BASE_URL => 'https://lets-chat-backend-5wa8.onrender.com/v1/';

  @override
  String get BASE_GOOGLE_MAPS_URL => 'https://maps.googleapis.com/maps/api';
}
