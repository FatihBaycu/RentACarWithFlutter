class CarDetails {
  String description;
  int carId;
  String carName;
  String brandName;
  int modelYear;
  String colorName;
  double dailyPrice;
  String imagePath;
  int brandId;
  int colorId;
  int carFindexPoint;


    CarDetails(
      this.description,
      this.carId,
      this.carName,
      this.brandName,
      this.modelYear,
      this.colorName,
      this.dailyPrice,
      this.imagePath,
      this.brandId,
      this.colorId,
      this.carFindexPoint
      );

     CarDetails.fromJson(Map json){
      this.carId=int.tryParse(json["carId"].toString());
      this.brandId=json["brandId"];
      this.colorId=json["colorId"];
      this.colorName=json["colorName"];
      this.brandName=json["brandName"];
      this.carName=json["carName"];
      this.modelYear=json["modelYear"];
      this.dailyPrice=double.tryParse(json["dailyPrice"].toString());
      this.description=json["description"];
      this.carFindexPoint=json["carFindexPoint"];
      this.imagePath=json["imagePath"];
    }

    Map toJson(){
    Map carDetailsJsonFormat={
      "carId":this.carId,
      "brandId":this.brandId,
      "colorId":this.colorId,
      "carName":this.carName,
      "colorName":this.colorName,
      "brandName":this.brandName,
      "modelYear":this.modelYear,
      "dailyPrice":this.dailyPrice,
      "description":this.description,
      "carFindexPoint":this.carFindexPoint,
      "imagePath":this.imagePath
    };
      return carDetailsJsonFormat;
    }

}
