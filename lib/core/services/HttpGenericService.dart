import 'dart:convert';

import 'package:flutter_http_demo2/controllers/auth_controller.dart';
import 'package:flutter_http_demo2/core/ResponseService.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

AuthController authController=Get.put(AuthController());

 class  HttpGenericService{


  var getToken="Bearer "+authController.token().token.toString();


     genericHttGet(String path)async{
   return await http.get(
      Uri.parse(path),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':getToken
      },
    );
  }


  generateHttpPost<T>(T entity,String url){
   return http.post(
      Uri.parse(url),
      body: (jsonEncode(entity)),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':getToken
      },
    );
  }

  generateHttpPut<T>(T entity,String url){
    return http.post(
      Uri.parse(url),
      body: (jsonEncode(entity)),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':getToken
      },
    );
  }


 }