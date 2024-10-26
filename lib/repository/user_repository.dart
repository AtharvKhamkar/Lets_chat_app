import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lets_chat/services/api_client_service.dart';

class UserRepository {
  final apiClient = ApiClientService();

  Future? userList()async{
    try {
      Response? response = await apiClient.get('/user/users-list');
      debugPrint('Response of the userList function : $response');
      return response?.body['response'];
    } catch (e) {
      debugPrint('Error in the UserRepository :: userList :: $e');
    }
  }
}