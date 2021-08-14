import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_http_demo2/controllers/auth_controller.dart';
import 'package:flutter_http_demo2/controllers/user_controller.dart';
import 'package:flutter_http_demo2/models/users/token.dart';
import 'package:flutter_http_demo2/models/users/user_for_login.dart';
import 'package:flutter_http_demo2/screens/car/car_list_screen.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../globalVariables.dart';
String apiUrl=GlobalVariables.apiUrl;

class AuthService{

  AuthController authController=Get.put(AuthController());
  UserController userController=Get.put(UserController());


 login(UserForLogin userForLogin)async{
    var response= await http.post(
        Uri.parse(apiUrl+"auth/login"),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', },
        body: jsonEncode(userForLogin.toJsonForAdd())
    );
    if(response.statusCode==200){
      Token token = Token.fromJson(json.decode(response.body)["data"]);
      token.token="Bearer ${token.token}";
      authController.token(token);
      userController.getUserByEmail(userForLogin.email!);
      Get.to(CarListScreen());
    }
    else{print(response.body);
      Get.snackbar("Login Error", "You'r email or password is wrong");
    //Get.to(CarListScreen());
    }
  }

  getByEmail(String email){



  }

}