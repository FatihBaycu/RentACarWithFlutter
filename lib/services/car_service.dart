import 'package:flutter_http_demo2/globalVariables.dart';
import 'package:http/http.dart' as http;

class CarService {
  static Future getAll() => http.get(Uri.http(GlobalVariables.apiUrl, "cars"));

  static Future getCarDetails() {
    return http.get(Uri.parse("https://10.0.2.2:5001/api/Cars/getcardetail"));
  }
  static Future getCarDetails2() {
    return http.get(Uri.parse("https://run.mocky.io/v3/2152d89d-c609-4e5d-9a63-6c42477cb5c3"));
  }

}
