import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Drawer drawer = Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Fatih Baycu"),
            accountEmail: Text("fatih.baycu@gmail.com"),
            currentAccountPicture: Image.asset("assets/user_photos/profilePhoto.jpg"),
            // otherAccountsPictures: [
            //   CircleAvatar(
            //     child: Text("A"),
            //     backgroundColor: Colors.pink,
            //   ),
            // ],
          ),
          // DrawerHeader(
          //
          //   decoration: BoxDecoration(color:Colors.blue),
          //   child: Align(
          //     alignment: Alignment.center,
          //     child: ListTile(leading: Icon(Icons.car_rental, size: 36,),
          //       title: Text("Rent A Car",style: TextStyle(fontSize: 20),
          //       ),
          //     ),
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
