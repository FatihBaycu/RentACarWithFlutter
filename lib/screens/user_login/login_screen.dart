import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_http_demo2/controllers/user_controller.dart';


import 'package:flutter_http_demo2/models/users/user_for_login.dart';
import 'package:flutter_http_demo2/services/auth_service.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  double screenHeight=Get.height;
  double screenWidth=Get.height;
  var email=TextEditingController();
  var password=TextEditingController();


  AuthService authService=Get.put(AuthService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Screen"),),
      body: buildBody(),
    );
  }

  buildBody() {
    email.text="string@string.com";
    password.text="string";


    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  bottom: screenHeight *0.1
              ),
              child: SizedBox(
                width: screenWidth *0.9,
                height: screenHeight *0.3,
                child: Image.network(
                    "https://www.nascarsrental.com/images/haber/sanliurfa-rent-a-car-5f6882138e96e.jpg"),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(screenHeight / 30),
              child: TextFormField(
                controller: email,
                decoration: InputDecoration(
                  labelText: "Email",
                    hintText: "Email",
                    filled: true,
                    fillColor: Colors.red,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)))),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(screenHeight / 30),
              child: TextFormField(
                cursorColor: Colors.red,
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Password",
                    labelText: "Password",
                    filled: true,
                    fillColor: Colors.red,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)))),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(screenHeight / 30),
              child: TextButton(
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.pink)),
                onPressed: () {

                  UserForLogin userForLogin=new UserForLogin("fatih.baycu@gmail.com", "123456789");
                    userForLogin.email=email.text;
                    userForLogin.password=password.text;
                  authService.login(userForLogin);
                },
              ),
            ),
            GestureDetector(
              onTap: (){print("Yardım Seçildi.");},
              child: Padding(
                padding: EdgeInsets.all(screenHeight / 30),
                child: Text("Help ?",style: TextStyle(fontWeight: FontWeight.bold),),
              ),
            )
          ],
        ),
      ),
    );
  }


  }


