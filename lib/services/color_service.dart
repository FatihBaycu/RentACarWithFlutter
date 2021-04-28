import 'package:flutter_http_demo2/globalVariables.dart';
import 'package:http/http.dart' as http;
class ColorService{
    static Future getAll() => http.get(Uri.http(GlobalVariables.apiUrl, "colors"));
}