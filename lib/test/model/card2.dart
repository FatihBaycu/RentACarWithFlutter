class Card2 {
  int? id;
  String? cardNumber;
  String? cardOnName;
  String? cardValidDate;
  String? cardCvv;
  int? customerId;
  String? cardType;

  Card2({
      this.id, 
      this.cardNumber, 
      this.cardOnName, 
      this.cardValidDate, 
      this.cardCvv, 
      this.customerId, 
      this.cardType});

  Card2.fromJson(dynamic json) {
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

}