/// id : 1
/// carId : 1
/// imagePath : "Uploads/Images/CarImages/defaultImage.png"
/// date : "2021-03-02T00:00:00"

class CarImages2 {
  int? _id;
  int? _carId;
  String? _imagePath;
  String? _date;

  int? get id => _id;
  int? get carId => _carId;
  String? get imagePath => _imagePath;
  String? get date => _date;

  CarImages2({
      int? id, 
      int? carId, 
      String? imagePath, 
      String? date}){
    _id = id;
    _carId = carId;
    _imagePath = imagePath;
    _date = date;
}

  CarImages2.fromJson(dynamic json) {
    _id = json["id"];
    _carId = json["carId"];
    _imagePath = json["imagePath"];
    _date = json["date"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["carId"] = _carId;
    map["imagePath"] = _imagePath;
    map["date"] = _date;
    return map;
  }

}