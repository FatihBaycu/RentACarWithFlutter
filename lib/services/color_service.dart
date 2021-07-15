import 'package:flutter_http_demo2/globalVariables.dart';
import 'package:flutter_http_demo2/models/color.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String apiUrl=GlobalVariables.apiUrl;

class ColorService{
    static Future getAll()async => await http.get(Uri.parse(apiUrl+"colors/getall"));

    static Future colorAdd(Color color)async{
        return await http.post(Uri.parse(apiUrl+"colors/addcolor"),
                    headers:<String, String>{'Content-Type': 'application/json; charset=UTF-8',},
                    body:jsonEncode(color.toJsonForAdd()));
    }

    static Future colorUpdate(Color color)async{
        return await http.put(Uri.parse(apiUrl+"colors/updatecolor"),
                headers:<String, String>{'Content-Type': 'application/json; charset=UTF-8',},
                body:jsonEncode(color.toJson()));
    }


    }