import 'package:get_it/get_it.dart';
import 'package:lets_chat/services/chat_service.dart';
import 'package:lets_chat/services/shared_preference_service.dart';

Future<void> registerServices() async {
  final GetIt getIt = GetIt.instance;

  getIt.registerLazySingleton<ChatService>(() => ChatService());
  getIt.registerLazySingletonAsync<SharedPreferenceService>(
      () async => await SharedPreferenceService.getInstance());
}
