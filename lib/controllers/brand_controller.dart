import 'dart:convert';

import 'package:flutter_http_demo2/models/brand.dart';
import 'package:flutter_http_demo2/services/brand_service.dart';
import 'package:get/get.dart';

class BrandController extends GetxController{
  var isLoading=true.obs;
  var brandList=<Brand>[].obs;

  @override
  Future<void> onInit() async {
    await getAll();
    super.onInit();
  }

   Future<void> getAll()async {
    try{
      isLoading(true);
      await BrandService.getAll().then((response) {
        var result= (jsonDecode(response.body)["data"] as List ).map((e) => Brand.fromJson(e)).toList();
       if(result!=null){brandList.addAll(result);}
      });
    }
    finally{isLoading(false);}
   }





}