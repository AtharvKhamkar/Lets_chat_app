import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:lets_chat/modals/chat_history_model..dart';
import 'package:lets_chat/modals/chat_room_model.dart';
import 'package:lets_chat/modals/send_messsage_model.dart';
import 'package:lets_chat/repository/chat_repository.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:lets_chat/services/chat_service.dart';
import 'package:lets_chat/utils/util_function.dart';
import 'package:lets_chat/widgets/custom_toast_util.dart';

class ChatController extends GetxController with StateMixin<dynamic> {
  final GetIt _getIt = GetIt.instance;
  late ChatService _chatService;
  final _chatRepo = ChatRepository();
  final messages = <types.Message>[].obs;

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

    List<Message> chatHistory = [];
    _chatService.messageStream.addListener(() {
      chatHistory = _chatService.messageStream.value;
      messages.clear();

      try {
        if (chatHistory.isNotEmpty) {
          processMessage(chatHistory);
        }
      } catch (e) {
        debugPrint('Error parsing message: $e');
      }
    });

    debugPrint(
        'Reached execution before for loop -------> ${chatHistory.length}');
  }

  void processMessage(List<Message> chatHistory) {
    for (var messageData in chatHistory) {
      //Only add new message in the message List if the message is not present in the previous message list.
      if (!messages.any((msg) => msg.id == messageData.id)) {
        debugPrint(
            'MessageData in the connectToSocket function is $messageData');

        final String messageType = messageData.messageType; // Default to text
        late final types.Message receivedMessage;

        if (messageType == 'TEXT') {
          receivedMessage = types.TextMessage(
              author: types.User(id: messageData.senderId),
              id: messageData.id,
              text: messageData.content,
              createdAt:
                  DateTime.parse(messageData.createdAt).millisecondsSinceEpoch);
        } else if (messageType == 'IMAGE') {
          receivedMessage = types.ImageMessage(
              author: types.User(id: messageData.senderId),
              id: messageData.id,
              name: 'test name',
              size: 10,
              uri: messageData.content);
        } else {
          debugPrint('Unknown message type: $messageType');
          continue; // Skip unknown message types
        }

        debugPrint('message before adding received message $receivedMessage');
        messages.insert(0, receivedMessage);
      }
    }
  }

  Future<void> sendMessage(
    String roomId,
    String senderId,
    String text,
  ) async {
    final SendMesssageModel sendMessageData = SendMesssageModel(
        roomId: roomId, senderId: senderId, content: text, messageType: 'TEXT');

    _chatService.sendMessage(sendMessageData);

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

  Future<void> sendImageMessage(String roomId, String senderId) async {
    if (isLoading.value) return;
    isLoading(true);
    errorMessages('');
    update();

    //Pick local file
    final pickedFile = await UtilFunction()
        .chooseFile(type: FileType.custom, allowedExtensions: ['png']);

    if (pickedFile != null) {
      debugPrint('picked file path : ${pickedFile.path}');
      try {
        //Upload local file to upload message image endpoint
        final uploadResponse =
            await _chatRepo.uploadImageRequest(pickedFile.path);
        debugPrint('Result of the uploaded file is $uploadResponse');
        if (uploadResponse['success']) {
          CustomToastUtil.showSucessToast(
              message: 'Image uploaded successfully');

          debugPrint(
              'Result of the uri is ${uploadResponse['response']['uri']}');

          //create SendMessageModel object for sending ImageMessage
          final SendMesssageModel sendMessageData = SendMesssageModel(
              roomId: roomId,
              senderId: senderId,
              content: uploadResponse['response']['uri'],
              messageType: 'IMAGE');

          // final sendImageMessage = types.ImageMessage(
          //     author: types.User(id: senderId),
          //     id: sendMessageData['Id'],
          //     name: uploadResponse['response']['name'],
          //     size: uploadResponse['response']['size'],
          //     uri: sendMessageData['content']);

          // messages.insert(0, sendImageMessage);

          //Send message to server
          _chatService.sendMessage(sendMessageData);
        }
      } catch (e) {
        debugPrint('No file was picked');
        update();
        isLoading(false);
      }
    }
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
