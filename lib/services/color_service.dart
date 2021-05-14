import 'package:flutter/cupertino.dart';
import 'package:flutter_http_demo2/globalVariables.dart';
import 'package:flutter_http_demo2/models/color.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String apiUrl=GlobalVariables.apiUrl;

class ColorService{
    static Future getAll() => http.get(Uri.parse(apiUrl+"colors/getall"));

    static Future colorAdd(Color color){
        return http.post(Uri.parse(apiUrl+"colors/addcolor"),
                headers:
                <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',},
                body:jsonEncode(color.toJsonForAdd()));
    }
}