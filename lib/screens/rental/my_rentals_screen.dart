import 'package:flutter/material.dart';
import 'package:flutter_http_demo2/controllers/rental_controller.dart';
import 'package:flutter_http_demo2/globalVariables.dart';
import 'package:get/get.dart';

class MyRentalsScreen extends StatefulWidget {
  const MyRentalsScreen({Key? key}) : super(key: key);

  @override
  _MyRentalsScreenState createState() => _MyRentalsScreenState();
}

class _MyRentalsScreenState extends State<MyRentalsScreen> {

  RentalController rentalController=Get.put(RentalController(),permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("myRentals".tr),),
      body: buildBody(),
    );
  }

  buildBody() {
    return Obx((){
      return ListView.builder(
          itemCount:rentalController.rentalDetail.length ,
          itemBuilder: (context,index){
            var rentalDetails=rentalController.rentalDetail[index];
            late String userAvatarUrl=GlobalVariables.apiUrlBase+rentalDetails.imagePath!;
            return ListTile(
              leading: SizedBox(
                child: CircleAvatar(

                    backgroundImage: NetworkImage(userAvatarUrl),
                    radius: 30,
                    //child: Image.network(GlobalVariables.apiUrlBase+rentalDetails.imagePath!,fit: BoxFit.cover,)
                ),
              ),
              title: Text(rentalDetails.carName!),
              subtitle: Text(rentalDetails.brandName!),
              trailing: Column(children: [
                Text("rentalsRent".tr+rentalDetails.rentDate!),
                Text("rentalsReturn".tr+rentalDetails.returnDate!),
              ],),
            );
          });

    });

  }
}
