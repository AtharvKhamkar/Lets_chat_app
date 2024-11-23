import 'package:flutter/material.dart';
import 'package:lets_chat/modals/chat_room_model.dart';
import 'package:lets_chat/services/api_client_service.dart';

class ChatRepository {
  final apiClient = ApiClientService();

  Future<ChatRoomModel?> createRoom(String userId, String receiverId) async {
    try {
      Map<String, dynamic> body = {'receiverId': receiverId};

      Map<String, dynamic> headers = {'x-user-id': userId};
      final response =
          await apiClient.post('/chat/create', body: body, headers: headers);
      final roomDetails = response['response'];
      if (roomDetails != null) {
        return ChatRoomModel.fromJson(roomDetails);
      }
    } catch (e) {
      debugPrint('Error in the ChatRepository :: createRoom :: $e');
    }
    return null;
  }

  Future<dynamic> uploadImageRequest(dynamic byte) async {
    try {
      Map<String, String> file = {"file": byte};

      final response = await apiClient.multipartRequest('/chat/upload-image',
          files:
              file); //change in backend instead of imageFile parameter use file parameter
      return response;
    } catch (e) {
      debugPrint('Error in the ChatRepository :: uploadImageRequest :: $e');
    }
  }
}
