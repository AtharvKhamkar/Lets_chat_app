import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lets_chat/modals/chat_room_model.dart';
import 'package:lets_chat/repository/chat_repository.dart';

class ChatController extends GetxController with StateMixin<dynamic>{
  final _chatRepo = ChatRepository();

  //Booleans
  var isLoading = false.obs;
  var hasData = false.obs;

  //Strings
  var errorMessages = "".obs;

  Future<dynamic> createChatRoom(String userId, String receiverId)async{
    if(isLoading.value) return;
    isLoading(true);
    update();

    ChatRoomModel? result = await _chatRepo.createRoom(userId, receiverId);
    debugPrint('Result of the create room process :: $result');
    isLoading(false);
    update();
    return result;
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

