import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_http_demo2/screens/car_add_screen.dart';
import 'package:flutter_http_demo2/screens/car_list_screen.dart';
import 'package:flutter_http_demo2/screens/color_screen.dart';


class MyHttpOverrides extends HttpOverrides {

  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(ApiDemo());
}

//void main() => runApp(ApiDemo());

class ApiDemo extends StatefulWidget {
  @override
  _ApiDemoState createState() => _ApiDemoState();
}

class _ApiDemoState extends State<ApiDemo> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       routes: {
            "/":(BuildContext context)=>CarListScreen(),
            "/car-list":(BuildContext context)=>CarListScreen(),
            "/car-add":(BuildContext context)=>CarAddScreen(),
            "/color":(BuildContext context)=>CarAddScreen(),
          },
      initialRoute: "/",
    );
  }
}