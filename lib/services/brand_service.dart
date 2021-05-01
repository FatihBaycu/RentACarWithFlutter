import 'package:http/http.dart' as http;
class BrandService{
    static Future getAll() => http.get(Uri.parse("https://10.0.2.2:5001/api/brands/getall"));
}