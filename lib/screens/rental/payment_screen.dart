import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_http_demo2/controllers/car_controller.dart';
import 'package:flutter_http_demo2/controllers/card_controller.dart';
import 'package:flutter_http_demo2/controllers/rental_controller.dart';
import 'package:flutter_http_demo2/controllers/user_controller.dart';
import 'package:flutter_http_demo2/core/text_input/custom_input_formatter.dart';
import 'package:flutter_http_demo2/globalVariables.dart';
import 'package:flutter_http_demo2/models/card.dart';
import 'package:flutter_http_demo2/models/rental.dart';
import 'package:flutter_http_demo2/models/users/user_detail.dart';

import 'package:get/get.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  CardController cardController = Get.put(CardController());
  CarController carController = Get.put(CarController());
  RentalController rentalController = Get.put(RentalController());
  UserController userController = Get.put(UserController(),permanent: true);

  CardModel cardModel=CardModel();
  Rental rental=Rental.withEmpty();
  UserDetail userDetail=UserDetail.withEmpty();


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool switchControl = false;
  var cardOnName = TextEditingController();
  var cardNumber = TextEditingController();
  var cardValidDate = TextEditingController();
  var cardCvv = TextEditingController();
  var cardType = TextEditingController();

  @override
  void initState() {
    userDetail=userController.user();

    cardController.getCardsByCustomerId(userDetail.customerId!);
    rental=rentalController.rental();
    rental.customerId=userDetail.customerId;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
      ),
      body: buildBody(),
    );
  }

  buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(runSpacing: 10,
            children: [
              buildCarInfo(),
              buildForm(),
              buildCardList(),
            ]),
      ),
    );
  }

  buildCardList() {
    return Obx(() {
      if (cardController.isLoading.value)
        return Center(child: CircularProgressIndicator());
      else
        return ListView.builder(
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: cardController.cardList.length,
            itemBuilder: (context, int index) {
              var card = cardController.cardList[index];
              return ListTile(
                leading: CircleAvatar(
                    backgroundColor:
                        card.cardType == "Visa" ? Colors.blue : Colors.red,
                    child: Text(
                      card.cardType!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )),
                title: Text(card.cardNumber!),
                subtitle: Text(card.cardValidDate!),
                trailing: Text(card.cardOnName!),
                onTap: () {
                  cardOnName.text = card.cardOnName!;
                  cardNumber.text = card.cardNumber!;
                  cardValidDate.text = card.cardValidDate!;
                  cardCvv.text = card.cardCvv!;
                  cardType.text = card.cardType!;
                },
                dense: false,
                autofocus: true,
                selectedTileColor: Colors.red,
                tileColor: Colors.black12,
              );
            });
    });
  }

  saveCard(){
    cardModel.cardType=cardType.text;
    cardModel.cardNumber=cardNumber.text;
    cardModel.cardCvv=cardCvv.text;
    cardModel.cardValidDate=cardValidDate.text;
    cardModel.cardOnName=cardOnName.text;
    cardModel.customerId=userDetail.customerId;

  }

  Form buildForm() {
    return Form(
        key: _formKey,
        child: Wrap(
          runSpacing: 10,
          children: [
            TextFormField(
              controller: cardOnName,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Card on Name"),
            ),
            TextFormField(
              controller: cardNumber,
              keyboardType: TextInputType.number,
              maxLength: 19,
              inputFormatters: [
                CustomInputFormatter(),
              ],
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Card Number"),
            ),
            TextFormField(
              controller: cardValidDate,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Card Valid Date"),
            ),
            TextFormField(
              maxLength: 3,
              controller: cardCvv,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Card CVV"),
            ),
            TextFormField(
              controller: cardType,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Card Type"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Save Card"),
                Switch(
                  value: switchControl,
                  activeTrackColor: Colors.white,
                  activeColor: Colors.blueGrey,
                  inactiveTrackColor: Colors.black54,
                  inactiveThumbColor: Colors.grey,
                  onChanged: (data) {
                    setState(() {
                      switchControl = data;
                    });
                    print("Switch : $data");
                  },
                ),
                SizedBox(
                    width: Get.height * 0.3,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.green)),
                        onPressed: () {
                          if(switchControl){saveCard();cardController.addCard(cardModel);}
                          rentalController.addRental(rental)
                              .then((value) => Get.snackbar("Success", "Car Rented.",duration: Duration(seconds: 3)))
                              .then((value) => Get.offAllNamed("/car-list"));
                        },
                        child: Text("PAY")))
              ],
            ),
          ],
        ));
  }

  String buildDateFormat(DateTime dateTime) {
    String convertedDateTime = "${dateTime.year.toString()}-"
        "${dateTime.month.toString().padLeft(2, '0')}-"
        "${dateTime.day.toString().padLeft(2, '0')} ";
    return convertedDateTime;
  }

  buildCarInfo() {
    int totalDay = rentalController.rental().returnDate!.day -
        rentalController.rental().rentDate!.day;
    int? totalPrice = totalDay == 0
        ? carController.carDetail().dailyPrice
        : totalDay * carController.carDetail().dailyPrice!;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("BRAND: ${carController.carDetail().brandName}"),
                  Text("MODEL: ${carController.carDetail().carName}"),
                  Text("RENT DATE: ${buildDateFormat(rentalController.rental().rentDate!)}"),
                  Text("RETURN DATE: ${buildDateFormat(rentalController.rental().returnDate!)}"),
                  Text("TOTAL DAY: ${totalDay == 0 ? 1 : totalDay}"),
                  Text("TOTAL PRICE: $totalPrice \$"),
                ],
              ),
            ],
          ),
          SizedBox(),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(GlobalVariables.apiUrlBase +
                            carController.carDetail().imagePath!)),
                    shape: BoxShape.circle,
                    color: Colors.red),
                height: 200,
                width: 200,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
