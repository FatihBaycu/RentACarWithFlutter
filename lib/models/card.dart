// class Card{
//   int? id;
//   String? cardNumber;
//   String? cardOnName;
//   String? cardValidDate;
//   String? cardCvv;
//   int? customerId;
//   String? cardType;
//
//     Card(this.id,this.cardNumber,this.cardOnName,this.cardValidDate,this.cardCvv,this.customerId,this.cardType);
//
//
//
//       Card.fromJson(Map json){
//       this.id =             ["", null].contains(  json['id'])             ? 0      : json['id'];
//       this.cardNumber =     ["", null].contains(  json['cardNumber'])     ? "null" : json['cardNumber'];
//       this.cardOnName =     ["", null].contains(  json['cardOnName'])     ? "null" : json['cardOnName'];
//       this.cardValidDate =  ["", null].contains(  json['cardValidDate'])  ? "null" : json['cardValidDate'];
//       this.cardCvv =        ["", null].contains(  json['cardCvv'])        ? "null" : json['cardCvv'];
//       this.customerId =     ["", null].contains(  json['customerId'])     ? 0      : json['customerId'];
//       this.cardType =       ["", null].contains(  json['cardType'])       ? "null" : json['cardType'];
//     }
//
//     Map toJson(){
//     Map cardJsonFormat={
//       "id":this.id,
//       "cardNumber":this.cardNumber,
//       "cardOnName":this.cardOnName,
//       "cardValidDate":this.cardValidDate,
//       "cardCvv":this.cardCvv,
//       "customerId":this.customerId,
//       "cardType":this.cardType
//     };
//       return cardJsonFormat;
//     }
//
//
//     Map toJsonToAdd(){
//     Map cardJsonFormat={
//       "cardNumber":this.cardNumber,
//       "cardOnName":this.cardOnName,
//       "cardValidDate":this.cardValidDate,
//       "cardCvv":this.cardCvv,
//       "customerId":this.customerId,
//       "cardType":this.cardType
//     };
//       return cardJsonFormat;
//     }
//
// }

class Card {
  int? id;
  String? cardNumber;
  String? cardOnName;
  String? cardValidDate;
  String? cardCvv;
  int? customerId;
  String? cardType;

  Card({
    this.id,
    this.cardNumber,
    this.cardOnName,
    this.cardValidDate,
    this.cardCvv,
    this.customerId,
    this.cardType});

  Card.fromJson(dynamic json) {
    id = json["id"];
    cardNumber = json["cardNumber"];
    cardOnName = json["cardOnName"];
    cardValidDate = json["cardValidDate"];
    cardCvv = json["cardCvv"];
    customerId = json["customerId"];
    cardType = json["cardType"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["cardNumber"] = cardNumber;
    map["cardOnName"] = cardOnName;
    map["cardValidDate"] = cardValidDate;
    map["cardCvv"] = cardCvv;
    map["customerId"] = customerId;
    map["cardType"] = cardType;
    return map;
  }
  //
  // Map<String, dynamic> toJsonForAdd() {
  //   var map = <String, dynamic>{};
  //   map["cardNumber"] = cardNumber;
  //   map["cardOnName"] = cardOnName;
  //   map["cardValidDate"] = cardValidDate;
  //   map["cardCvv"] = cardCvv;
  //   map["customerId"] = customerId;
  //   map["cardType"] = cardType;
  //   return map;
  // }

}