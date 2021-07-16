import 'package:flutter/material.dart';
import 'package:flutter_http_demo2/screens/brand/brand_screen.dart';
import 'package:flutter_http_demo2/screens/car/car_add_screen.dart';
import 'package:flutter_http_demo2/screens/car/car_list_screen.dart';
import 'package:flutter_http_demo2/screens/color/color_screen.dart';

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
          ListTile(title: Text("Home page",style: TextStyle(fontSize: 18),),onTap: (){customRoute(context,CarListScreen());}),
          ListTile(title: Text("Brands",style: TextStyle(fontSize: 18),),onTap: (){customRoute(context,BrandScreen());},),
          ListTile(title: Text("Colors",style: TextStyle(fontSize: 18),),onTap: (){customRoute(context,ColorScreen());}),
          ListTile(title: Text("Add Car",style: TextStyle(fontSize: 18),),onTap: (){customRoute(context,CarAddScreen());},
          ),
        ],
      ),
    );


    return drawer;
  }
  customRoute(BuildContext context, screen) {
    Navigator.push(context, MaterialPageRoute(builder: (builder) => screen));
  }
}
