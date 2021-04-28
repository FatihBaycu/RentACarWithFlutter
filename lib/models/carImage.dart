class CarImage{
  int id;
  int carId;
  String imagePath;
  DateTime date;

    CarImage(this.id,this.carId,this.imagePath,this.date);

      CarImage.fromJson(Map json){
      this.id=json["id"];
      this.carId=json["carId"];
      this.imagePath=json["imagePath"];
      this.date=json["date"];
    }

    Map toJson(){
    Map carImagesJsonFormat={
      "id":this.id,
      "carId":this.carId,
      "imagePath":this.imagePath,
      "date":this.date
    };
      return carImagesJsonFormat;
  }
}
