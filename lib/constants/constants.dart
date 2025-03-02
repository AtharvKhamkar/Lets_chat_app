import 'package:lets_chat/actions/attachment_actions.dart';
import 'package:lets_chat/constants/asset_path.dart';

class Constants {
  static const BASE_URL = 'https://lets-chat-backend-5wa8.onrender.com/v1/';
  static const BASE_CHAT_URL = 'https://lets-chat-backend-5wa8.onrender.com';
  static const BASE_IOS_CHAT_LOCAL_URL = 'ws://127.0.0.1:2525';
  static const BASE_ANDROID_CHAT_LOCAL_URL = 'ws://10.0.2.2:2525';
  static String kCurrentUserId = '';
  static String kCurrentRoomId = '';
  static String kGoogleMapsApiKey = 'AIzaSyBJoSmyBE4NkgE7-jb1wqiK5Da_KTZTl5M';

  static final List<Map<String, dynamic>> kAttachmentTypesOptions = [
    {
      'assetPath': AssetPath.kGallery,
      'title': 'Gallery',
      'action': () => AttachmentActions.onGalleryOptionTap(
          Constants.kCurrentRoomId, Constants.kCurrentUserId)
    },
    {
      'assetPath': AssetPath.kCamera,
      'title': 'Camera',
      'action': AttachmentActions.onCameraOptionTap
    },
    {
      'assetPath': AssetPath.kLocation,
      'title': 'Location',
      'action': AttachmentActions.onLocationOptionTap
    },
    {
      'assetPath': AssetPath.kDocument,
      'title': 'Document',
      'action': AttachmentActions.onDocumentOptionTap
    },
  ];
}
