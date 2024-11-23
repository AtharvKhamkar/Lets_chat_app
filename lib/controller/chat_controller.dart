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
  var isCurrentUserTyping = false.obs;
  var isOtherUserTyping = false.obs;

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

  Future<void> connectToSocket(String roomId, String userId) async {
    debugPrint(
        'Socket connection request started :: connectToSocket :: ChatController');
    await _chatService.connect(roomId, userId);
    await _chatService.joinRoom(roomId, userId);

    ///Check typing status of the other user
    _chatService.typingStream.addListener(() {
      isOtherUserTyping.value = _chatService.typingStream.value;
    });

    _chatService.messageStream.addListener(() {
      final chatHistory = _chatService.messageStream.value;
      messages.clear();

      for (var messageData in chatHistory) {
        debugPrint(
            'MessageData in the connectToSocket function is $messageData');
        final receivedMessage = types.TextMessage(
          author: types.User(id: messageData['senderId'] ?? 'unknown'),
          id: messageData['_id'] ?? DateTime.now().toIso8601String(),
          text: messageData['content'] ?? '[No content]',
          createdAt: messageData['createdAt'] != null
              ? DateTime.parse(messageData['createdAt']).millisecondsSinceEpoch
              : DateTime.now().millisecondsSinceEpoch,
        );
        debugPrint('message before adding received message $receivedMessage');
        messages.insert(0, receivedMessage);
      }
    });
  }

  Future<void> sendMessage(String roomId, String senderId, String text) async {
    final Map<String, dynamic> sendMessageData = {
      'Id': DateTime.now().toIso8601String(),
      'senderId': senderId,
      'content': text,
      'createdAt': DateTime.now().millisecondsSinceEpoch,
    };
    _chatService.sendMessage(roomId, senderId, sendMessageData);
    // final newMessage = types.TextMessage(
    //   author: types.User(id: sendMessageData['senderId']),
    //   id: sendMessageData['Id'],
    //   text: sendMessageData['content'],
    //   createdAt: sendMessageData['createdAt'],
    // );

    // debugPrint(
    //     'created new message before inserting in an array is $newMessage');

    // messages.insert(0, newMessage);
  }

  Future<void> sendTypingEvent(
      String roomId, String receiverId, bool status) async {
    _chatService.sendTypingEvent(roomId, receiverId, status);
  }

  void onTextChanged(
      String roomId, String text, String receiverId, bool status) {
    if (text.isNotEmpty) {
      sendTypingEvent(roomId, receiverId, true);
    } else {
      sendTypingEvent(roomId, receiverId, false);
    }
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
