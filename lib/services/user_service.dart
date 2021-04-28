import 'package:http/http.dart' as http;

class UserService{
    static String apiUrl="10.0.2.2:3000";

    static Future getAllUsers() => http.get(Uri.https("localhost:44342","api/users/getall"));


}