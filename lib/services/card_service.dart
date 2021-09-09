import 'package:flutter_http_demo2/core/services/HttpGenericService.dart';
import 'package:flutter_http_demo2/globalVariables.dart';
import 'package:flutter_http_demo2/models/card.dart';

var apiUrl=GlobalVariables.apiUrl;


class CardService{

    HttpGenericService httpGenericService=new HttpGenericService();

   Future getCardsByCustomerId(int customerId)async{return httpGenericService.genericHttGet(apiUrl+"Cards/getcardsbycustomerid?customerid=$customerId");}

   Future addCard(CardModel card)async{return await httpGenericService.generateHttpPost(card.toJsonForAdd(), apiUrl+"cards/addcard");}

}