import 'dart:ffi';

class Car{
  int? id;
  int? brandId;
  int? colorId;
  String? carName;
  int? modelYear;
  double? dailyPrice;
  String? description;
  int? carFindexPoint;

  Car.empty();


  Car.required({this.brandId, this.colorId, this.carName, this.modelYear,
      this.dailyPrice, this.description, this.carFindexPoint});

  Car(
    this.id,
    this.brandId,
    this.colorId,
    this.carName,
    this.modelYear,
    this.dailyPrice,
    this.description,
    this.carFindexPoint,
    );

    Car.fromJson(dynamic json){
      this.id = ["", null].contains(json['id']) ? 0 : json['id'];
      this.brandId = ["", null].contains(json['brandId']) ? "null" : json['brandId'];
      this.colorId = ["", null].contains(json['colorId']) ? 0 : json['colorId'];
      this.carName = ["", null].contains(json["carName"]) ? "null" : json['carName'];
      this.modelYear = ["", null].contains(json['modelYear'].toString()) ? 0 : json['modelYear'];
      this.dailyPrice = ["", null].contains(json['dailyPrice']) ? 0 : json['dailyPrice'];
      this.description = ["", null].contains(json['description']) ? "null" : json['description'];
      this.carFindexPoint = ["", null].contains(json['carFindexPoint']) ? 0 : json['carFindexPoint'];
    }

    Map<String,dynamic>  toJson() {
      var map=<String,dynamic>{};
      map["id"] = this.id;
      map["brandId"] = this.brandId;
      map["colorId"] = this.colorId;
      map["carName"] = this.carName;
      map["modelYear"] = this.modelYear;
      map["dailyPrice"] = this.dailyPrice;
      map["description"] = this.description;
      map["carFindexPoint"] = this.carFindexPoint;
      return map;
    }


  Map<String,dynamic>  toJsonForAdd() {
    return {
      "brandId": this.brandId,
      "colorId": this.colorId,
      "carName": this.carName,
      "modelYear": this.modelYear,
      "dailyPrice": dailyPrice,
      "description": this.description,
      "carFindexPoint":this.carFindexPoint
    };
  }


  Map<String,dynamic>  toJsonForDelete() {
    return {
      "id": this.id
    };
  }
}