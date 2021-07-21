import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_http_demo2/models/rental.dart';
import 'package:http/http.dart' as http;

import '../globalVariables.dart';

var apiUrl=GlobalVariables.apiUrl;





class RentalService{



  static Future getRentalsByCarId(int carId) async{return await http.get(Uri.parse(apiUrl+"Rentals/getrentalsbycarid?carId=$carId"));}
  static Future getRentalsByCustomerId(int customerId) async{return await http.get(Uri.parse(apiUrl+"Rentals/getrentalsbycustomer?customerId=$customerId"));}

  static Future addRental(Rental rental)async{
    debugPrint(rental.toJson().toString());
    return await http.post(
        Uri.parse(apiUrl+"rentals/addrental"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(rental.toJsonToAdd()));

  }
}