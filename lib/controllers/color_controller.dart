import 'dart:convert';

import 'package:flutter_http_demo2/models/color.dart';
import 'package:flutter_http_demo2/services/color_service.dart';
import 'package:get/get.dart';

class ColorController extends GetxController{
  var isLoading=true.obs;
  var colorList=<Color>[].obs;


  ColorService colorService=new ColorService();

  @override
  Future<void> onInit() async {
    await getAll();
    super.onInit();
  }


  Future<void> getAll() async{
    try{
      isLoading(true);
      await colorService.getAll().then((response){
        var result=(jsonDecode(response.body)["data"] as List).map((e) => Color.fromJson(e)).toList();
        if(result!=null){colorList.assignAll(result);}
      } );
    }
    finally{
      isLoading(false);
    }
  }

}