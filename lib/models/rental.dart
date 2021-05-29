class User{

  int? id;
  int? carId;
  int? customerId;
  DateTime? rentDate;
  DateTime? returnDate;


    User(this.id,this.carId,this.customerId,this.rentDate,this.returnDate);
    
    User.fromJson(Map json){
      this.id=json["id"];
      this.carId=json["carId"];
      this.customerId=json["customerId"];
      this.returnDate=json["returnDate"];
    }

    Map toJson(){
    Map rentalJsonFormat={
      "id":this.id,
      "carId":this.carId,
      "customerId":this.customerId,
      "rentDate":this.rentDate,
      "returnDate":this.returnDate
    };
      return rentalJsonFormat;
    }
}