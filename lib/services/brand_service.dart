import 'package:flutter_http_demo2/globalVariables.dart';
import 'package:http/http.dart' as http;


String apiUrl=GlobalVariables.apiUrl;
class BrandService{
    static Future getAll() => http.get(Uri.parse(apiUrl+"brands/getall"));
}