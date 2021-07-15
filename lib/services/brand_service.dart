import 'dart:convert';

import 'package:flutter_http_demo2/globalVariables.dart';
import 'package:flutter_http_demo2/models/brand.dart';
import 'package:http/http.dart' as http;


String apiUrl=GlobalVariables.apiUrl;
class BrandService{
    static Future getAll() async=> await http.get(Uri.parse(apiUrl+"brands/getall"));

    static Future brandAdd(Brand brand) async {
        await http.post(
            Uri.parse(apiUrl + "brands/addbrand"),

            headers:
            <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',},

            body: jsonEncode(brand.toJsonForAdd()));
    }

    static Future brandUpdate(Brand brand) async {
        await http.put(
            Uri.parse(apiUrl + "brands/updatebrand"),
            headers:<String, String>{'Content-Type': 'application/json; charset=UTF-8',},
            body: jsonEncode(brand.toJson()));
    }

}