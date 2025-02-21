import 'package:get/get.dart';
import 'package:lets_chat/Routes/app_router_constant.dart';
import 'package:lets_chat/controller/chat_controller.dart';
import 'package:lets_chat/screens/location_share_screen.dart';

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
    Get.toNamed(AppRouterConstant.kLocationSharing);
  }

  static void onDocumentOptionTap() {
    print('Document option tapped');
  }
}
