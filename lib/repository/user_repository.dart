import 'package:flutter/material.dart';
import 'package:lets_chat/modals/user_details_model.dart';
import 'package:lets_chat/modals/user_modal.dart';
import 'package:lets_chat/services/api_client_service.dart';

class UserRepository {
  final apiClient = ApiClientService();

  Future<List<User>?> userList() async {
    try {
      final response = await apiClient.get('/user/users-list');
      debugPrint('Response of the userList function : $response');

      if (response != null && response['response'] is List) {
        return (response['response'] as List)
            .map((userJson) => User.fromJson(userJson))
            .toList();
      }
    } catch (e) {
      debugPrint('Error in the UserRepository :: userList :: $e');
    }
    return null;
  }

  Future<UserDetailsModel?> userDetails(String userId) async {
    try {
      Map<String, dynamic> headers = {'x-user-id': userId};
      final response = await apiClient.get('/user/detail', headers: headers);
      debugPrint('Response of the userDetails function : $response');

      final profileDetails = response['response'];
      return UserDetailsModel.fromJson(profileDetails);
    } catch (e) {
      debugPrint('Error in the UserRepository :: userList :: $e');
    }
    return null;
  }
}
