import 'package:flutter_http_demo2/controllers/brand_controller.dart';
import 'package:flutter_http_demo2/controllers/car_controller.dart';
import 'package:flutter_http_demo2/controllers/color_controller.dart';
import 'package:get/get.dart';

class CarBinding implements Bindings{

  @override
  void dependencies() {
    Get.put<CarController>(CarController());
    Get.put<ColorController>(ColorController());
    Get.put<BrandController>(BrandController());

  }

}