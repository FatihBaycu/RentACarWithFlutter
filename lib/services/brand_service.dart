import 'package:flutter_http_demo2/core/services/HttpGenericService.dart';
import 'package:flutter_http_demo2/globalVariables.dart';
import 'package:flutter_http_demo2/models/brand.dart';

String apiUrl=GlobalVariables.apiUrl;

class BrandService{

    HttpGenericService httpGenericService=new HttpGenericService();

     Future getAll() async=> await httpGenericService.genericHttGet(apiUrl+"brands/getall");

     Future getAll2() async{return httpGenericService.genericHttGet(apiUrl+"brands/getall");}

     Future brandAdd(Brand brand) async { return await httpGenericService.generateHttpPost(brand.toJsonForAdd(), apiUrl + "brands/addbrand");}

     Future brandUpdate(Brand brand) async {return await httpGenericService.generateHttpPost(brand.toJson(), apiUrl + "brands/updatebrand");}

}