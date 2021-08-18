import 'package:flutter_http_demo2/core/services/HttpGenericService.dart';
import 'package:flutter_http_demo2/globalVariables.dart';
import 'package:flutter_http_demo2/models/color.dart';

String apiUrl=GlobalVariables.apiUrl;

class ColorService{

      HttpGenericService httpGenericService=new HttpGenericService();

     Future getAll()async => await httpGenericService.genericHttGet(apiUrl+"colors/getall");
     Future colorAdd(Color color)async{ return httpGenericService.generateHttpPost(color.toJsonForAdd(), apiUrl+"colors/addcolor");}
     Future colorUpdate(Color color)async{ return httpGenericService.generateHttpPut(color.toJson(), apiUrl+"colors/updatecolor");}


    }