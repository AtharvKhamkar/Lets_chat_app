import 'package:get_it/get_it.dart';
import 'package:lets_chat/services/chat_service.dart';

Future<void> registerServices() async {
  final GetIt getIt = GetIt.instance;

  getIt.registerSingleton<ChatService>(ChatService());
}
