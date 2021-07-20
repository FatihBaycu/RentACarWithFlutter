import 'package:flutter_http_demo2/models/rental.dart';
import 'package:flutter_http_demo2/services/rental_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RentalController extends GetxController {

  // var rental = Rental.withEmpty().obs;
  var rental = new Rental(0, 0, 0, DateTime.now(), DateTime.now()).obs;

  addRental(Rental rental)async {
    await RentalService.addRental(rental);
  }
}
