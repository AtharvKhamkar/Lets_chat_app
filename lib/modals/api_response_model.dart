class ApiResponseModel {
  int? statusCode;
  dynamic response;
  String? message;
  bool? success;

  ApiResponseModel({
    this.statusCode,
    this.response,
    this.message,
    this.success,
  });

  @override
  String toString() {
    return 'ApiResponseModel(statusCode: $statusCode, response: $response, message: $message, success: $success)';
  }

  factory ApiResponseModel.fromJson(Map<String, dynamic> json) {
    return ApiResponseModel(
      statusCode: json['statusCode'] as int? ?? 500,
      response: json['response'] as dynamic,
      message:
          json['message'] as String? ?? 'No success response message available',
      success: json['success'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'statusCode': statusCode,
        'response': response,
        'message': message,
        'success': success,
      };
}

class ApiErrorModel {
  int? statusCode;
  dynamic response;
  String? message;
  bool? success;

  ApiErrorModel({
    this.statusCode,
    this.response,
    this.message,
    this.success,
  });

  @override
  String toString() {
    return 'ApiErrorModel(statusCode: $statusCode, response: $response, message: $message, success: $success)';
  }

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) {
    return ApiErrorModel(
      statusCode: json['statusCode'] as int? ?? 500,
      response: json['response'] as dynamic,
      message:
          json['message'] as String? ?? 'No error response message available',
      success: json['success'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'statusCode': statusCode,
        'response': response,
        'message': message,
        'success': success,
      };
}
