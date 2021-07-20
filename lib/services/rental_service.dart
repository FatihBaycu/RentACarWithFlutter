import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_http_demo2/models/rental.dart';
import 'package:http/http.dart' as http;

import '../globalVariables.dart';

var apiUrl=GlobalVariables.apiUrl;


class RentalService{

  static Future addRental(Rental rental)async{
    debugPrint(rental.toJson().toString());
    return await http.post(
        Uri.parse(apiUrl+"cards/addcard"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(rental.toJsonToAdd()));

  }

}