class ApiResponseModel {
  String? statusCode;
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
      statusCode: json['statusCode'] as String?,
      response: json['response'] == null
          ? null
          : json['response'] as Map<String, dynamic>,
      message: json['message'] as String?,
      success: json['success'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
        'statusCode': statusCode,
        'response': response,
        'message': message,
        'success': success,
      };
}
