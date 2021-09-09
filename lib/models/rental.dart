class Rental{
  int? id;
  int? carId;
  int? customerId;
  DateTime? rentDate;
  DateTime? returnDate;

  Rental.withEmpty();
  Rental(this.id,this.carId,this.customerId,this.rentDate,this.returnDate);

  Rental.fromJson(Map json){
      this.id = ["", null].contains(json['id']) ? 0 : json['id'];
      this.carId = ["", null].contains(json['carId']) ? 0 : json['carId'];
      this.customerId = ["", null].contains(json['customerId']) ? 0 : json['customerId'];
      this.rentDate = ["", null].contains(json['rentDate']) ? 0 : json['rentDate'];
      this.returnDate = ["", null].contains(json['returnDate']) ? 0 : json['returnDate'];
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


    Map<String,dynamic> toJsonToAdd() {
      return {
        "carId": this.carId,
        "customerId": this.customerId,
        "rentDate": rentDate!.toIso8601String(),
        "returnDate": returnDate!.toIso8601String(),
      };
    }



}