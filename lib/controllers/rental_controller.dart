import 'dart:convert';

import 'package:flutter_http_demo2/controllers/user_controller.dart';
import 'package:flutter_http_demo2/models/rental.dart';
import 'package:flutter_http_demo2/models/rental_details.dart';
import 'package:flutter_http_demo2/models/users/user_detail.dart';
import 'package:flutter_http_demo2/services/rental_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RentalController extends GetxController {

  // var rental = Rental.withEmpty().obs;
  var rental = new Rental(0, 0, 2, DateTime.now(), DateTime.now()).obs;
  var rentalDetail=<RentalDetails>[].obs;
  var isLoading=true.obs;

  UserController userController = Get.put(UserController(),permanent: true);

  @override
  void onInit() {
    getRentalsByCustomerId(userController.user().customerId!);
    super.onInit();
  }

  void getRentalsByCustomerId(int customerId) async {
    try {
      await RentalService.getRentalsByCustomerId(customerId).then((response) {
        isLoading(true);
        var result = (jsonDecode(response.body)["data"] as List)
            .map((e) => RentalDetails.fromJson(e))
            .toList();
        if (result != null) {
          rentalDetail.assignAll(result);
        }
      });
    } finally {
      isLoading(false);
    }
  }

  Future<void>addRental(Rental rental)async {
    await RentalService.addRental(rental);
  }
}
