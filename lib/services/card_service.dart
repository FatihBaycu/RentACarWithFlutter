import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_http_demo2/globalVariables.dart';
import 'package:flutter_http_demo2/models/card.dart' hide C;
import 'package:http/http.dart' as http;

var apiUrl=GlobalVariables.apiUrl;


class CardService{

  static Future getCardsByCustomerId(int customerId)async{return await http.get(Uri.parse(apiUrl+"Cards/getcardsbycustomerid?customerid=$customerId"));}


  static Future addCard(CardModel card)async{
    debugPrint(card.toJson().toString());
    return await http.post(
        Uri.parse(apiUrl+"cards/addcard"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(card.toJsonForAdd()));

  }


}