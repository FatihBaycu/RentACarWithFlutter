import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_http_demo2/controllers/auth_controller.dart';
import 'package:flutter_http_demo2/globalVariables.dart';
import 'package:flutter_http_demo2/models/car.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

String apiUrl=GlobalVariables.apiUrl;
AuthController authController=Get.put(AuthController());

class CarService {



  static Future getCarDetails(String token) async{
    return await http.get(
      Uri.parse(apiUrl+"Cars/getcardetail"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization':token
    },
  );}
  static Future getCarDetailsByCarId(int carId) async{return await http.get(Uri.parse(apiUrl+"Cars/getcardetailsbycar?carId=$carId"));}

  static Future getCarDetailsByColorId(int colorId)async{return await http.get(Uri.parse(apiUrl+"Cars/getcardetailsbycolor?colorId=$colorId"));}
  static Future getCarDetailsByBrandId(int brandId)async{return await http.get(Uri.parse(apiUrl+"Cars/getcardetailsbybrand?brandId=$brandId"));}
  static Future getCarDetailsByBrandAndColorId(int brandId,int colorId)async{return await  http.get(Uri.parse(apiUrl+"Cars/getcardetailsbybrandandcolor?brandId=$brandId&colorId=$colorId"));}
  static Future getCarImagesByCarId(int carId)async=>await http.get(Uri.parse(apiUrl+"CarImages/getbycarid?id=$carId"));


  static Future addCar(Car car)async{
     debugPrint(car.toJson().toString());
    return await http.post(
        Uri.parse(apiUrl+"cars/addcar"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(car.toJsonForAdd()));

  }

  static Future updateCar(Car car)async{
    debugPrint(car.toJson().toString());
    return await http.put(
        Uri.parse(apiUrl+"cars/updatecar"),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
        body: jsonEncode(car.toJson()));
  }
}
