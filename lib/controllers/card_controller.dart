import 'dart:convert';

import 'package:flutter_http_demo2/models/card.dart';
import 'package:flutter_http_demo2/services/card_service.dart';
import 'package:get/get.dart';

class CardController extends GetxController {
  var isLoading = true.obs;
  var cardList = <CardModel>[].obs;

  @override
  void onInit() {
    getCardsByCustomerId(2);
    super.onInit();
  }

  void getCardsByCustomerId(int customerId) async {
    try {
      await CardService.getCardsByCustomerId(customerId).then((response) {
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
    await CardService.addCard(card);
  }
}
