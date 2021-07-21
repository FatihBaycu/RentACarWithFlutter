import 'package:flutter/material.dart';
import 'package:flutter_http_demo2/controllers/car_controller.dart';
import 'package:flutter_http_demo2/controllers/rental_controller.dart';
import 'package:flutter_http_demo2/globalVariables.dart';
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
  CarController carController=Get.put(CarController());

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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: Get.height*0.50,
            width: Get.width*0.999,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(GlobalVariables.apiUrlBase +carController.carDetail().imagePath!)),
                  shape: BoxShape.circle,
                  color: Colors.red),
            ),
          ),
          //ElevatedButton(
          //     onPressed: () {
          //       print(rentDate);
          //       print(returnDate);
          //     },
          //     child: Text("Print Dates")),
          ElevatedButton(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.date_range),
                Text('Pick a rent date'),
              ],
            ),
            onPressed: () {
              showRentDateDialog();
            },
          ),
          ElevatedButton(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.date_range),
                Text('Pick a return date'),
              ],
            ),
            onPressed: () {
              showReturnDateDialog();
            },
          ),
          TextButton(
              onPressed: () {
                Get.to(() => PaymentScreen());
              },
              child: Text("Go to Payment")),
        ],
      ),
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
       // var newDate=DateTime.utc(rentDate.year,rentDate.month,rentDate.day);
        rentalController.rental().rentDate=date;

      });
    });
  }

  bool checkReturnDate(DateTime rentDate,DateTime returnDate){
    if(returnDate.day < rentDate.day  || returnDate.day==rentDate.day)
      return false;
    else
      return true;

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
        //var newDate=DateTime.utc(returnDate.year,returnDate.month,returnDate.day);
        rentalController.rental().returnDate=date;
      });
    });
  }





}
