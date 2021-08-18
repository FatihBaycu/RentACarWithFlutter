import 'package:flutter/material.dart';
import 'package:flutter_http_demo2/controllers/user_controller.dart';
import 'package:flutter_http_demo2/screens/user_screens/login_screen.dart';
import 'package:get/get.dart';

class DrawerWidget extends StatelessWidget {

  UserController userController = Get.put(UserController(),permanent: true);


  @override
  Widget build(BuildContext context) {
    Drawer drawer = Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Obx(()=>Text("${userController.user().firstName!.capitalizeFirst} ${userController.user().lastName!.capitalizeFirst}")),
            accountEmail: Obx(()=>Text(userController.user().email!)),
            currentAccountPicture: Image.asset("assets/user_photos/profilePhoto.jpg"),

            otherAccountsPictures: [
              CircleAvatar(
                child: IconButton(
                 icon:Icon(Icons.logout,color: Colors.red),
                  onPressed: () {
                   Get.offAll(()=>LoginScreen());
                  },
                ),
                backgroundColor: Colors.white,
              ),
            ],
          ),
          // DrawerHeader(
          //   decoration: BoxDecoration(color:Colors.blue),
          //   child: Align(
          //     alignment: Alignment.center,
          //     child:ListTile(leading: Icon(Icons.car_rental, size: 36,),title: Text("Rent A Car",style: TextStyle(fontSize: 20),),),
          //   ),
          // ),
          ListTile(title: Text("Home page", style: TextStyle(fontSize: 18),),onTap: (){Get.toNamed("/car-list");}),
          ListTile(title: Text("Brands",    style: TextStyle(fontSize: 18),),onTap: (){Get.toNamed("/brand");},),
          ListTile(title: Text("Colors",    style: TextStyle(fontSize: 18),),onTap: (){Get.toNamed("/color");}),
          ListTile(title: Text("Add Car",   style: TextStyle(fontSize: 18),),onTap: (){Get.toNamed("/car-add");},),
          ListTile(title: Text("My Rentals",   style: TextStyle(fontSize: 18),),onTap: (){Get.toNamed("/my-rentals");},),
        ],
      ),
    );


    return drawer;
  }

}
