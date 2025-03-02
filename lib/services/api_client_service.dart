import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lets_chat/constants/app_config.dart';
import 'package:lets_chat/main_prod.dart';

class ApiClientService {
  static final ApiClientService _instance = ApiClientService._internal();

  factory ApiClientService() {
    return _instance;
  }

  ApiClientService._internal() {
    _initialize();
  }

  AppConfig appConfig = getIt<AppConfig>();

  final Dio _dio = Dio();
  final Dio _googleMapsDio = Dio();

  Map<String, String> _headers() {
    Map<String, String> map = {};
    map['content-type'] = "application/json";
    return map;
  }

  void _initialize() {
    _dio.options.baseUrl = appConfig.BASE_URL;
    _googleMapsDio.options.baseUrl = appConfig.BASE_GOOGLE_MAPS_URL;
  }

  Dio chooseApiClient({bool useGoogleMaps = false}) {
    return useGoogleMaps ? _googleMapsDio : _dio;
  }

  Future<dynamic> get(String endpoint, {Map<String, dynamic>? headers}) async {
    try {
      final response =
          await _dio.get(endpoint, options: Options(headers: headers));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        Future.error('Error while get request');
      }
    } on DioException catch (e) {
      debugPrint(e.message);
    }
  }

  Future<dynamic> post(String endpoint,
      {required Map<String, dynamic> body,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.post(endpoint,
          data: body, options: Options(headers: headers));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        Future.error('Error while post request');
      }
    } on DioException catch (e) {
      debugPrint(e.message);
    }
  }

  ///Multipart request
  ///used to upload file uploads
  Future<dynamic> multipartRequest(String endpoint,
      {Map<String, dynamic> request = const {},
      Map<String, String> files = const {},
      Map<String, dynamic>? headers}) async {
    try {
      var multipartFile = <String, MultipartFile>{};

      for (var item in files.entries) {
        multipartFile[item.key] = await MultipartFile.fromFile(item.value,
            filename: item.value.split("/").last);
      }

      FormData formData = FormData.fromMap({...request, ...multipartFile});
      debugPrint('Formdata before file upload request :: $formData');

      final response = await _dio.post(endpoint,
          data: formData, options: Options(headers: headers));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        Future.error('Error while post request');
      }
    } on DioException catch (e) {
      debugPrint(e.message);
    }
  }
}
