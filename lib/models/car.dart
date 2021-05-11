class Car{
  int id;
  int brandId;
  int colorId;
  String carName;
  int modelYear;
  double dailyPrice;
  String description;
  int carFindexPoint;

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

  
    
    Car.fromJson(Map json){
      this.id=json["id"];
      this.brandId=json["brandId"];
      this.colorId=json["colorId"];
      this.carName=json["carName"];
      this.modelYear=json["modelYear"];
      this.dailyPrice=double.tryParse(["dailyPrice"].toString());
      this.description=json["description"];
      this.carFindexPoint=json["carFindexPoint"];
    }

    Map<String,dynamic>  toJson() {
      return {
        "id": this.id,
        "brandId": this.brandId,
        "colorId": this.colorId,
        "carName": this.carName,
        "modelYear": this.modelYear,
        "dailyPrice": dailyPrice,
        "description": this.description,
        "carFindexPoint":this.carFindexPoint
      };
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