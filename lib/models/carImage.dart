class CarImage{
  int? id;
  int? carId;
  String? imagePath;
  String? date;

    CarImage(this.id,this.carId,this.imagePath,this.date);

      CarImage.fromJson(dynamic json){
      this.id=int.parse(json["id"].toString());
      this.carId=json["carId"];
      this.imagePath=json["imagePath"];
      this.date=json["date"];
    }

    Map<String,dynamic> toJson(){
    var map=<String,dynamic>{
      "id":this.id,
      "carId":this.carId,
      "imagePath":this.imagePath,
      "date":this.date
    };
      return map;
  }
}
