import 'package:flutter_http_demo2/core/services/HttpGenericService.dart';
import 'package:flutter_http_demo2/globalVariables.dart';
import 'package:flutter_http_demo2/models/car.dart';

String apiUrl=GlobalVariables.apiUrl;

class CarService {

    HttpGenericService httpGenericService=new HttpGenericService();

    Future getCarDetails()async{ return await httpGenericService.genericHttGet(apiUrl+"Cars/getcardetail");}

   Future getCarDetailsByCarId(int carId) async{return await httpGenericService.genericHttGet(apiUrl+"Cars/getcardetailsbycar?carId=$carId");}

   Future getCarDetailsByColorId(int colorId)async{return httpGenericService.genericHttGet(apiUrl+"Cars/getcardetailsbycolor?colorId=$colorId");}

   Future getCarDetailsByBrandId(int brandId)async{return httpGenericService.genericHttGet(apiUrl+"Cars/getcardetailsbybrand?brandId=$brandId");}

   Future getCarDetailsByBrandAndColorId(int brandId,int colorId)async{return httpGenericService.genericHttGet(apiUrl+"Cars/getcardetailsbybrandandcolor?brandId=$brandId&colorId=$colorId");}

   Future getCarImagesByCarId(int carId)async=>httpGenericService.genericHttGet(apiUrl+"CarImages/getbycarid?id=$carId");

   Future addCar(Car car)async{return httpGenericService.generateHttpPost(car.toJsonForAdd(),apiUrl+"cars/addcar"); }

   Future updateCar(Car car)async{return httpGenericService.generateHttpPost(car.toJson(),apiUrl+"cars/updatecar"); }

}

