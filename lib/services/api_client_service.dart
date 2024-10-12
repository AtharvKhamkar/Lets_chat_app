import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lets_chat/constants/constants.dart';

class ApiClientService {
  final Dio _dio = Dio();

  ApiClientService(){
    _dio.options.baseUrl = Constants.BASE_URL;
    _dio.options.headers['Content-Type'] = 'application/json';
  }

  Future<dynamic> get(String endpoint,{Map<String,dynamic>? headers})async{
    try {
      final response = await _dio.get(endpoint,options: Options(headers: headers));
      return response.data;
    }on DioException catch (e) {
      debugPrint(e.message);
      
    }
  }

  Future<dynamic> post(String endpoint,{required Map<String,dynamic> body, Map<String,dynamic>? headers})async{
    try {
      final response = await _dio.post(endpoint,data: body,options: Options(headers: headers));
      return response.data;
    }on DioException  catch (e) {
      debugPrint(e.message);
    }
  }
}