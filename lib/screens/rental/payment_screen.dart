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

  CardController cardController = Get.put(CardController(),permanent: true);
  RentalController rentalController = Get.put(RentalController(),permanent: true);
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
        title: Text("payment".tr),
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
                  border: OutlineInputBorder(), hintText: "cardOnName".tr),
            ),
            TextFormField(
              controller: cardNumber,
              keyboardType: TextInputType.number,
              maxLength: 19,
              inputFormatters: [
                CustomInputFormatter(),
              ],
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "cardNumber".tr),
            ),
            TextFormField(
              controller: cardValidDate,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "cardValidDate".tr),
            ),
            TextFormField(
              maxLength: 3,
              controller: cardCvv,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "cardCVV".tr),
            ),
            TextFormField(
              controller: cardType,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "cardType".tr),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("saveCard".tr),
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
                              .then((value) => Get.snackbar("success".tr, "carRented".tr,duration: Duration(seconds: 3)))
                              .then((value) => Get.offNamed("/car-list"));
                        },
                        child: Text("pay".tr)))
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
   

      return GetX<CarController>(
        init: CarController(),
        builder: (_carController){

 int totalDay = rentalController.rental().returnDate!.day -
        rentalController.rental().rentDate!.day;
    int? totalPrice = totalDay == 0
        ? _carController.carDetail().dailyPrice
        : totalDay * _carController.carDetail().dailyPrice!;

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
                  Text("paymentBrand".tr +_carController.carDetail().brandName!),
                  Text("paymentModel".tr+_carController.carDetail().carName!),
                  Text("paymentRentDate".tr+ buildDateFormat(rentalController.rental().rentDate!)),
                  Text("paymentReturnDate".tr+buildDateFormat(rentalController.rental().returnDate!)),
                  Text("paymentTotalDay".tr+"${totalDay == 0 ? 1 : totalDay}"),
                  Text("paymentTotalPrice".tr+ totalPrice.toString()),
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
                            _carController.carDetail().imagePath!)),
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
        },

      );


  }
}
