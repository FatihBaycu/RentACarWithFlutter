import 'dart:convert';

import 'package:flutter_http_demo2/models/users/user_detail.dart';
import 'package:flutter_http_demo2/services/user_service.dart';
import 'package:get/get.dart';

class UserController extends GetxController{

  var isLoading=true.obs;
  var user=UserDetail.withEmpty().obs;

  void getUserByEmail(String email)async{
    try {
      await UserService.getUserByEmail(email).then((response) {
        isLoading(true);
        var result = (jsonDecode(response.body)["data"]);
        var userResponse=UserDetail.fromJson(result);
        if (result != null) { user(userResponse);}
        else{
          Get.snackbar("a", response.body);
        }
      });
    }
      finally{isLoading(false);}
    }
  }

