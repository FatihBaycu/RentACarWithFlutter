import 'package:http/http.dart' as http;

class CarService {
  //static Future getAll() => http.get(Uri.http(GlobalVariables.apiUrl, "cars/getall"));
  static Future getCarDetails(){return http.get(Uri.parse("https://10.0.2.2:5001/api/Cars/getcardetail"));}
  static Future getCarDetailsByColorId(int colorId){return http.get(Uri.parse("https://10.0.2.2:5001/api/Cars/getcardetail?colorId$colorId"));}

  static Future getCarImagesByCarId(int carId)=>http.get(Uri.parse("https://10.0.2.2:5001/api/CarImages/getbycarid?id=$carId"));
}
