import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_http_demo2/models/car.dart';
import 'package:http/http.dart' as http;


class CarService {
  //static Future getAll() => http.get(Uri.http(GlobalVariables.apiUrl, "cars/getall"));
  static Future getCarDetails(){return http.get(Uri.parse("https://10.0.2.2:5001/api/Cars/getcardetail"));}
  static Future getCarDetailsByColorId(int colorId){return http.get(Uri.parse("https://10.0.2.2:5001/api/Cars/getcardetailsbycolor?colorId=$colorId"));}
  static Future getCarDetailsByBrandId(int brandId){return http.get(Uri.parse("https://10.0.2.2:5001/api/Cars/getcardetailsbybrand?brandId=$brandId"));}
  static Future getCarDetailsByBrandAndColorId(int brandId,int colorId){return http.get(Uri.parse("https://10.0.2.2:5001/api/Cars/getcardetailsbybrandandcolor?brandId=$brandId&colorId=$colorId"));}
  static Future getCarImagesByCarId(int carId)=>http.get(Uri.parse("https://10.0.2.2:5001/api/CarImages/getbycarid?id=$carId"));
  static Future addCar(Car car){
     debugPrint(car.toJson().toString());
    return http.post(
        Uri.parse("https://10.0.2.2:5001/api/cars/addcar"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(car.toJsonForAdd()));

  }
}
