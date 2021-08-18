import 'package:flutter_http_demo2/controllers/auth_controller.dart';
import 'package:flutter_http_demo2/core/services/HttpGenericService.dart';
import 'package:flutter_http_demo2/models/rental.dart';
import 'package:get/get.dart';

import '../globalVariables.dart';

var apiUrl=GlobalVariables.apiUrl;
AuthController authController=Get.put(AuthController());

class RentalService{

  HttpGenericService httpGenericService=new HttpGenericService();

  var token=authController.token().token.toString();

   Future getRentalsByCarId(int carId) async{return await httpGenericService.genericHttGet(apiUrl+"Rentals/getrentalsbycarid?carId=$carId");}

   Future getRentalsByCustomerId(int customerId) async{return await httpGenericService.genericHttGet(apiUrl+"Rentals/getrentalsbycustomer?customerId=$customerId");}

   Future addRental(Rental rental)async{return httpGenericService.generateHttpPost(rental.toJsonToAdd(), apiUrl+"rentals/addrental");}
}