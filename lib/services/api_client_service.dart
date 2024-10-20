import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lets_chat/constants/constants.dart';

class ApiClientService {
  final Dio _dio = Dio();

  Map<String,String> _headers(){
    Map<String,String> map = {};
    map['content-type'] = "application/json";
    return map;
  }

  ApiClientService(){
    _dio.options.baseUrl = Constants.BASE_URL;
  }

  Future<dynamic> get(String endpoint,{Map<String,dynamic>? headers})async{
    try {
      final response = await _dio.get(endpoint,options: Options(headers: headers));
      if(response.statusCode == 200 || response.statusCode == 201){
        return response.data;
      }else{
        Future.error('Error while get request');
      }
    }on DioException catch (e) {
      debugPrint(e.message);
      
    }
  }

  Future<dynamic> post(String endpoint,{required Map<String,dynamic> body, Map<String,dynamic>? headers})async{
    try {
      final response = await _dio.post(endpoint,data: body,options: Options(headers: headers));
      if(response.statusCode == 200 || response.statusCode == 201){
        return response.data;
      }else{
        Future.error('Error while post request');
      }
    }on DioException  catch (e) {
      debugPrint(e.message);
    }
  }
}