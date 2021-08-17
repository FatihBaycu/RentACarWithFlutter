import 'package:flutter_http_demo2/models/users/token.dart';
import 'package:flutter_http_demo2/models/users/user_for_login.dart';
import 'package:flutter_http_demo2/services/auth_service.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{



  var isLoading=true.obs;
  var token=Token.withEmpty().obs;



}