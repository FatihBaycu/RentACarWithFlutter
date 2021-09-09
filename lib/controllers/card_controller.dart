import 'dart:convert';

import 'package:flutter_http_demo2/controllers/user_controller.dart';
import 'package:flutter_http_demo2/models/card.dart';
import 'package:flutter_http_demo2/services/card_service.dart';
import 'package:get/get.dart';

class CardController extends GetxController {
  var isLoading = true.obs;
  var cardList = <CardModel>[].obs;

  CardService cardService=new CardService();
  UserController userController=Get.put(UserController());

  @override
  void onInit() {
    getCardsByCustomerId(userController.user().customerId!);
    super.onInit();
  }

  void getCardsByCustomerId(int customerId) async {
    try {
      await cardService.getCardsByCustomerId(customerId).then((response) {
        isLoading(true);
        var result = (jsonDecode(response.body)["data"] as List)
            .map((e) => CardModel.fromJson(e))
            .toList();
        if (result != null) {
          cardList.assignAll(result);
        }
      });
    } finally {
      isLoading(false);
    }
  }

  addCard(CardModel card)async{
    await cardService.addCard(card);
  }
}
