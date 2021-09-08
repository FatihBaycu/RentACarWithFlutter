import 'package:flutter_http_demo2/globalVariables.dart';
import 'package:flutter_http_demo2/models/users/user_detail.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;



var apiUrl=GlobalVariables.apiUrl;

class UserService{



  static Future getUserByEmail(String email)async{
    return await http.get(Uri.parse(apiUrl+"Customers/getcustomerbyemail?email=$email"));
  }


}