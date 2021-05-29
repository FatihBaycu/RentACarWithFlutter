/// description : "Sedan"
/// carId : 4
/// carName : "A8"
/// brandName : "Audi"
/// modelYear : 2021
/// colorName : "Kırmızı"
/// dailyPrice : 500
/// imagePath : "Uploads/Images/CarImages/audiA8Kirmizi.jpg"
/// brandId : 1
/// colorId : 1
/// carFindexPoint : 10

class CarDetails2 {
  String? _description;
  int? _carId;
  String? _carName;
  String? _brandName;
  int? _modelYear;
  String? _colorName;
  int? _dailyPrice;
  String? _imagePath;
  int? _brandId;
  int? _colorId;
  int? _carFindexPoint;

  String? get description => _description;
  int? get carId => _carId;
  String? get carName => _carName;
  String? get brandName => _brandName;
  int? get modelYear => _modelYear;
  String? get colorName => _colorName;
  int? get dailyPrice => _dailyPrice;
  String? get imagePath => _imagePath;
  int? get brandId => _brandId;
  int? get colorId => _colorId;
  int? get carFindexPoint => _carFindexPoint;

  CarDetails2({
      String? description, 
      int? carId, 
      String? carName, 
      String? brandName, 
      int? modelYear, 
      String? colorName, 
      int? dailyPrice, 
      String? imagePath, 
      int? brandId, 
      int? colorId, 
      int? carFindexPoint})
  {
    _description = description;
    _carId = carId;
    _carName = carName;
    _brandName = brandName;
    _modelYear = modelYear;
    _colorName = colorName;
    _dailyPrice = dailyPrice;
    _imagePath = imagePath;
    _brandId = brandId;
    _colorId = colorId;
    _carFindexPoint = carFindexPoint;
}

  CarDetails2.fromJson(dynamic json) {
    _description = json["description"];
    _carId = json["carId"];
    _carName = json["carName"];
    _brandName = json["brandName"];
    _modelYear = json["modelYear"];
    _colorName = json["colorName"];
    _dailyPrice = json["dailyPrice"];
    _imagePath = json["imagePath"];
    _brandId = json["brandId"];
    _colorId = json["colorId"];
    _carFindexPoint = json["carFindexPoint"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["description"] = _description;
    map["carId"] = _carId;
    map["carName"] = _carName;
    map["brandName"] = _brandName;
    map["modelYear"] = _modelYear;
    map["colorName"] = _colorName;
    map["dailyPrice"] = _dailyPrice;
    map["imagePath"] = _imagePath;
    map["brandId"] = _brandId;
    map["colorId"] = _colorId;
    map["carFindexPoint"] = _carFindexPoint;
    return map;
  }

}