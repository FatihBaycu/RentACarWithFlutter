class CardModel {
  int? id;
  String? cardNumber;
  String? cardOnName;
  String? cardValidDate;
  String? cardCvv;
  int? customerId;
  String? cardType;

  CardModel({
    this.id,
    this.cardNumber,
    this.cardOnName,
    this.cardValidDate,
    this.cardCvv,
    this.customerId,
    this.cardType});

  CardModel.fromJson(dynamic json) {
    this.id = ["", null].contains(json['id']) ? 0 : json['id'];
    this.cardNumber = ["", null].contains(json['cardNumber']) ? "null" : json['cardNumber'];
    this.cardOnName = ["", null].contains(json['cardOnName']) ? "null" : json['cardOnName'];
    this.cardValidDate = ["", null].contains(json['cardValidDate']) ? "null" : json['cardValidDate'];
    this.cardCvv = ["", null].contains(json['cardCvv']) ? "null" : json['cardCvv'];
    this.customerId = ["", null].contains(json['customerId']) ? 0 : json['customerId'];
    this.cardType = ["", null].contains(json['cardType']) ? "null" : json['cardType'];
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

  Map<String, dynamic> toJsonForAdd() {
    var map = <String, dynamic>{};
    map["cardNumber"] = cardNumber;
    map["cardOnName"] = cardOnName;
    map["cardValidDate"] = cardValidDate;
    map["cardCvv"] = cardCvv;
    map["customerId"] = customerId;
    map["cardType"] = cardType;
    return map;
  }

}