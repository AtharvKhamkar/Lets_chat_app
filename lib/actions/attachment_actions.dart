import 'package:get/get.dart';
import 'package:lets_chat/controller/chat_controller.dart';

class AttachmentActions {
  static void onGalleryOptionTap(String roomId, String userId) async {
    final ChatController chatController = ChatController().initialized
        ? Get.find<ChatController>()
        : Get.put(ChatController());

    chatController.sendImageMessage(roomId, userId);
  }

  static void onCameraOptionTap() {
    print('camera option tapped');
  }

  static void onLocationOptionTap() {
    print('Location option tapped');
  }

  static void onDocumentOptionTap() {
    print('Document option tapped');
  }
}
