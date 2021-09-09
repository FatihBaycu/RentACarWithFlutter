import 'package:flutter/material.dart';
import 'package:flutter_http_demo2/controllers/user_controller.dart';
import 'package:flutter_http_demo2/screens/user_screens/login_screen.dart';
import 'package:flutter_http_demo2/services/localization_service.dart';
import 'package:get/get.dart';


// ignore: must_be_immutable
class DrawerWidget extends StatefulWidget {

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  UserController userController = Get.put(UserController(),permanent: true);

  @override
  Widget build(BuildContext context) {
  String selectedLang = LocalizationService.langs.first;
    Drawer drawer = Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Obx(()=>Text("${userController.user().firstName!.capitalizeFirst} ${userController.user().lastName!.capitalizeFirst}")),
            accountEmail: Obx(()=>Text(userController.user().email!)),
          currentAccountPicture: Image.asset("assets/user_photos/userPhoto.png"),
            //currentAccountPicture: Image.network(GlobalVariables.apiUrlBase+userController.user().picturePath!,fit: BoxFit.cover,),
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
          ListTile(title: Text("homePage".tr, style: TextStyle(fontSize: 18),),onTap: (){Get.toNamed("/car-list");}),
          ListTile(title: Text("brands".tr,    style: TextStyle(fontSize: 18),),onTap: (){Get.toNamed("/brand");},),
          ListTile(title: Text("colors".tr,    style: TextStyle(fontSize: 18),),onTap: (){Get.toNamed("/color");}),
          ListTile(title: Text("addCar".tr,   style: TextStyle(fontSize: 18),),onTap: (){Get.toNamed("/car-add");},),
          ListTile(title: Text("myRentals".tr,   style: TextStyle(fontSize: 18),),onTap: (){Get.toNamed("/my-rentals");},),
         
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: DropdownButton(
                icon: Icon(Icons.arrow_drop_down),
                value: selectedLang,
                items: LocalizationService.langs.map((String lang) {
                  return DropdownMenuItem(value: lang, child: Text(lang));
                }).toList(),
                onChanged: (String? value) {
                  // updates dropdown selected value
                  setState(() => selectedLang = value!);
                  // gets language and changes the locale
                  LocalizationService().changeLocale(value!);
                    Get.snackbar("language".tr, selectedLang,animationDuration: Duration(seconds: 0),duration: Duration(seconds:2));
                },
              ),
         ),
        ],
      ),
    );


    return drawer;
  }
}
