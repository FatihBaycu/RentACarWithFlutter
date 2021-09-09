import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_http_demo2/screens/brand/brand_screen.dart';
import 'package:flutter_http_demo2/screens/car/car_add_screen.dart';
import 'package:flutter_http_demo2/screens/car/car_list_screen.dart';
import 'package:flutter_http_demo2/screens/color/color_screen.dart';
import 'package:flutter_http_demo2/screens/rental/car_rental_screen.dart';
import 'package:flutter_http_demo2/screens/rental/my_rentals_screen.dart';
import 'package:flutter_http_demo2/screens/user_screens/login_screen.dart';
import 'package:flutter_http_demo2/services/localization_service.dart';
import 'package:get/get.dart';



class MyHttpOverrides extends HttpOverrides {

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(ApiDemo());
}

class ApiDemo extends StatefulWidget {
  @override
  _ApiDemoState createState() => _ApiDemoState();
}

class _ApiDemoState extends State<ApiDemo> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      locale: LocalizationService.locale,
      //locale: window.locale,
      fallbackLocale: LocalizationService.fallbackLocale,
      translations: LocalizationService(),

      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: "/car-list", page: ()=>CarListScreen()),
        GetPage(name: "/car-add", page:()=>CarAddScreen()),
        GetPage(name: "/color", page:()=>ColorScreen()),
        GetPage(name: "/brand", page:()=>BrandScreen()),
        GetPage(name: "/rental", page:()=>CarRentalScreen()),
        GetPage(name: "/my-rentals", page:()=>MyRentalsScreen()),
        GetPage(name: "/login-screen", page:()=>LoginScreen()),
      ],

      initialRoute: "/login-screen",
    );
  }
}