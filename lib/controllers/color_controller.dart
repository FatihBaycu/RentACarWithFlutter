import 'dart:convert';

import 'package:flutter_http_demo2/models/color.dart';
import 'package:flutter_http_demo2/services/color_service.dart';
import 'package:get/get.dart';

class ColorController extends GetxController{
  var isLoading=true.obs;
  var colorList=<Color>[].obs;

  @override
  void onInit() {
    getAll();
    super.onInit();
  }

  void getAll() async{
    try{
      isLoading(true);
      await ColorService.getAll().then((response){
        var result=(jsonDecode(response.body)["data"] as List).map((e) => Color.fromJson(e)).toList();
        if(result!=null){colorList.assignAll(result);}
      } );
    }
    finally{
      isLoading(false);
    }
  }

}