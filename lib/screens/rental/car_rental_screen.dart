import 'package:flutter/material.dart';
import 'package:flutter_http_demo2/controllers/card_controller.dart';
import 'package:flutter_http_demo2/controllers/rental_controller.dart';
import 'package:flutter_http_demo2/screens/rental/payment_screen.dart';
import 'package:get/get.dart';

class CarRentalScreen extends StatefulWidget {
  const CarRentalScreen({Key? key}) : super(key: key);

  @override
  _CarRentalScreenState createState() => _CarRentalScreenState();
}

class _CarRentalScreenState extends State<CarRentalScreen> {
  DateTime rentDate = DateTime.now();
  DateTime returnDate = DateTime.now();

  RentalController rentalController=Get.put(RentalController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rent"),
      ),
      body: buildBody(),
    );
  }

  buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
            onPressed: () {
              print(rentDate);
              print(returnDate);
            },
            child: Text("Print Dates")),
        ElevatedButton(
          child: Text('Pick a rent date'),
          onPressed: () {
            showRentDateDialog();
          },
        ),
        ElevatedButton(
          child: Text('Pick a return date'),
          onPressed: () {
            showReturnDateDialog();
          },
        ),
        ElevatedButton(
            onPressed: () {
              Get.to(() => PaymentScreen());
            },
            child: Text("Go to Payment")),
      ],
    );
  }

  showRentDateDialog() {
    return showDatePicker(
            context: context,
            initialDate: rentDate == null ? DateTime.now() : rentDate,
            firstDate: DateTime(2001),
            lastDate: DateTime(2022))
        .then((date) {
      setState(() {
        rentDate = date != null ? date : DateTime.now();
        rentalController.rental().rentDate=date;

      });
    });



  }

  showReturnDateDialog() {
    return showDatePicker(
            context: context,
            initialDate: returnDate == null ? DateTime.now() : returnDate,
            firstDate: DateTime(2001),
            lastDate: DateTime(2022))
        .then((date) {
      setState(() {
        returnDate = date != null ? date : DateTime.now();
        rentalController.rental().returnDate=date;
      });
    });
  }
}
