import 'package:lets_chat/services/api_client_service.dart';
import 'package:flutter/material.dart';


class AuthRepository {
  final apiClient = ApiClientService();
  Future? registerUser(String username,String email,String password)async{
    try {
      Map<String,dynamic> body = {
        "username":username.trim(),
        "email":email.trim(),
        "password":password.trim()
      };

      final response = await apiClient.post('auth/register', body: body);

      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}