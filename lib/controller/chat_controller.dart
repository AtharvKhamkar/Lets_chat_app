import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:lets_chat/modals/chat_room_model.dart';
import 'package:lets_chat/repository/chat_repository.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:lets_chat/services/chat_service.dart';

class ChatController extends GetxController with StateMixin<dynamic> {
  final GetIt _getIt = GetIt.instance;
  late ChatService _chatService;
  final _chatRepo = ChatRepository();
  final messages = <types.TextMessage>[].obs;

  //Booleans
  var isLoading = false.obs;
  var hasData = false.obs;

  //Strings
  var errorMessages = "".obs;

  @override
  void onInit() {
    _chatService = _getIt.get<ChatService>();
    super.onInit();
  }

  Future<dynamic> createChatRoom(String userId, String receiverId) async {
    if (isLoading.value) return;
    isLoading(true);
    update();

    ChatRoomModel? result = await _chatRepo.createRoom(userId, receiverId);
    debugPrint('Result of the create room process :: $result');
    isLoading(false);
    update();
    return result;
  }

  void connectToSocket(String roomId, String userId) {
    _chatService.connect(roomId, userId);
    _chatService.messageStream.addListener(() {
      final chatHistory = _chatService.messageStream.value;
      messages.clear();

      for (var messageData in chatHistory) {
        final receivedMessage = types.TextMessage(
          author: types.User(id: messageData['senderId']),
          id: messageData['_id'],
          text: messageData['content'],
          createdAt:
              DateTime.parse(messageData['timestamp']).millisecondsSinceEpoch,
        );
        messages.add(receivedMessage);
      }
    });
  }

  void sendMessage(String roomId, String senderId, String text) {
    _chatService.sendMessage(roomId, senderId, text);
    final newMessage = types.TextMessage(
      author: types.User(id: senderId),
      id: senderId,
      text: text,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    messages.add(newMessage);
  }

  @override
  void onClose() {
    // TODO: implement onClose
    _chatService.disconnect();
    super.onClose();
  }
}

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatBinding>(
      () => ChatBinding(),
      fenix: true,
    );
  }
}
