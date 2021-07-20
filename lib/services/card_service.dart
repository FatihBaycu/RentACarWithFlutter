import 'package:flutter_http_demo2/globalVariables.dart';
import 'package:http/http.dart' as http;

var apiUrl=GlobalVariables.apiUrl;


class CardService{

  static Future getCardsByCustomerId(int customerId)async{return await http.get(Uri.parse(apiUrl+"Cards/getcardsbycustomerid?customerid=$customerId"));}

}