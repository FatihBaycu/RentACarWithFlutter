import 'package:flutter/material.dart';
import 'package:flutter_http_demo2/screens/brand_screen.dart';
import 'package:flutter_http_demo2/screens/car_list_screen.dart';
import 'package:flutter_http_demo2/screens/color_screen.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Drawer drawer = Drawer(
      child: ListView(

        children: [
          DrawerHeader(
            decoration: BoxDecoration(color:Colors.blue),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: ListTile(leading: Icon(Icons.car_rental, size: 36,),
                    title: Text("Rent A Car",style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text("Home page",style: TextStyle(fontSize: 18),),
            onTap: (){customRoute(context,CarListScreen());},
          ),
          ListTile(
            title: Text("Brands",style: TextStyle(fontSize: 18),),
            onTap: (){customRoute(context,BrandScreen());},
          ),
          ListTile(
            title: Text("Colors",style: TextStyle(fontSize: 18),),
            onTap: (){customRoute(context,ColorScreen());},
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
