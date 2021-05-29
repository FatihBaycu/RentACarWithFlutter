class Card{
  int? id;
  String? cardNumber;
  String? cardOnNumber;
  String? cardValidDate;
  String? cardCvv;
  int? customerId;
  String? cardType;

    Card(this.id,this.cardNumber,this.cardOnNumber,this.cardValidDate,this.cardCvv,this.customerId,this.cardType);



      Card.fromJson(Map json){
      this.id=json["id"];
      this.cardNumber=json["cardNumber"];
      this.cardOnNumber=json["cardOnNumber"];
      this.cardValidDate=json["cardValidDate"];
      this.cardCvv=json["cardCvv"];
      this.customerId=json["customerId"];
      this.cardType=json["cardType"];
    }

    Map toJson(){
    Map cardJsonFormat={
      "id":this.id,
      "cardNumber":this.cardNumber,
      "cardOnNumber":this.cardOnNumber,
      "cardValidDate":this.cardValidDate,
      "cardCvv":this.cardCvv,
      "customerId":this.customerId,
      "cardType":this.cardType
    };
      return cardJsonFormat;
    }

}
