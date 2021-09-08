import 'package:flutter/material.dart';
import 'package:flutter_http_demo2/controllers/auth_controller.dart';
import 'package:flutter_http_demo2/controllers/user_controller.dart';
import 'package:flutter_http_demo2/models/users/user_for_login.dart';
import 'package:flutter_http_demo2/screens/user_screens/register_screen.dart';
import 'package:flutter_http_demo2/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

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


  AuthService authService=new AuthService();

  AuthController authController=Get.put(AuthController(),permanent: true);
  UserController userController=Get.put(UserController(),permanent: true);


  @override
  void initState() {
    // var sp= await SharedPreferences.getInstance();
    //
    // UserForLogin userForLogin =new UserForLogin.withEmpty();
    // userForLogin.email=sp.getString("email");
    // userForLogin.password=sp.getString("password");
    //
    //  authService.login(userForLogin);


    //  createInstance();
    fillBlanks();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(title: Text("loginScreen".tr),),
    body: buildBody(),
    );
  }


  Future createInstance()async{
    var sp= await SharedPreferences.getInstance();
    sp.setString("email","fatih.baycu@gmail.com");
    sp.setString("password","123456789");
  }


  Future fillBlanks()async{
    var sp= await SharedPreferences.getInstance();
    email.text=sp.get("email").toString();
    password.text=sp.get("password").toString();
  }

  editInstance()async{
    var sp= await SharedPreferences.getInstance();
    sp.setString("email",email.text);
    sp.setString("password",password.text);
  }

  buildBody() {
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
                child: 
                Image.asset("assets/carsImage.png"),
                //Text("projectName".tr),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(screenHeight / 30),
              child: TextFormField(
                controller: email,
                decoration: InputDecoration(
                  labelText: "email".tr,
                    hintText: "email".tr,
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
                    hintText: "password".tr,
                    labelText: "password".tr,
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
                  "login".tr,
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.pink)),
                onPressed: () {

                  UserForLogin userForLogin=new UserForLogin("fatih.baycu@gmail.com", "123456789");
                    userForLogin.email=email.text;
                    userForLogin.password=password.text;
                    editInstance();

                  authService.login(userForLogin);
                },
              ),
            ),
        ElevatedButton(
            style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.red)),
            onPressed: (){Get.to(RegisterScreen());},
            child: Text("register".tr)),
          ],
        ),
      ),
    );
  }
  }




