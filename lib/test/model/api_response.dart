import 'package:flutter_http_demo2/test/model/serializable.dart';

class ApiResponse<T extends Serializable> {
  bool? success;
  String? message;
  T? data;


  ApiResponse({this.success, this.message, this.data});

  factory ApiResponse.fromJson(Map<String, dynamic> json, Function(Map<String, dynamic>) create) {
    return ApiResponse<T>(
      success:json["success"],
      message:json["message"],
      data:create(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "success": this.success,
    "message": this.message,
    "data": this.data!.toJson(),
  };
}



