import 'dart:convert';

import 'package:dio/dio.dart';
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

      debugPrint('Request send to the server');

      final response = await apiClient.post('auth/register', body: body);

      debugPrint('Response from the server : $response');

      return response;
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future? loginUser(String email,String password)async{
    try {
      final loginData = {
        "email":email.trim(),
        "password":password.trim()
      };


      final response = await apiClient.post('auth/login', body: loginData);
      debugPrint('Response from the server : $response');

      return response;
      
      
    } catch (e) {
      debugPrint('$e');
    }
  }
}