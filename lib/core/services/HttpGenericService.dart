import 'dart:convert';
import 'package:flutter_http_demo2/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../ResponseService.dart';

AuthController authController = Get.put(AuthController());

class HttpGenericService {
  var getToken = "Bearer " + authController.token().token.toString();

  genericHttGet(String path) async {
    var response = await http.get(
      Uri.parse(path),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': getToken
      },
    );

    if(response.statusCode!=200)
        return Get.snackbar("title", "message");

   // ResponseSnackbarService.generateResponse(response);
    return response;
  }

  generateHttpPost<T>(T entity, String url) async {
    var response = await http.post(
      Uri.parse(url),
      body: (jsonEncode(entity)),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': getToken
      },
    );

    //ResponseSnackbarService.generateResponse(response);
    return response;
  }

  generateHttpPut<T>(T entity, String url) async {
    var response = await http.post(
      Uri.parse(url),
      body: (jsonEncode(entity)),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': getToken
      },
    );
   //ResponseSnackbarService.generateResponse(response);
    return response;
  }
}
