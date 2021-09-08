import 'dart:convert';
import 'package:get/get.dart';

class ResponseSnackbarService{

static  Future generateResponse(dynamic response)async{


  bool success=jsonDecode(response.body)["success"];
  String message=jsonDecode(response.body)["message"];


  if(message==null) {
    message = "null";
    print(success.toString()+message);
    return Get.snackbar(
        success.toString(), message.toString(), duration: Duration(seconds: 5));
  }
  else
    print(success.toString()+message);
  return Get.snackbar(
        success.toString(), message.toString(), duration: Duration(seconds: 5));
}
}