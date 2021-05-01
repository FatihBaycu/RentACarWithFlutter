import 'package:http/http.dart' as http;
class ColorService{
    static Future getAll() => http.get(Uri.parse("https://10.0.2.2:5001/api/colors/getall"));
}