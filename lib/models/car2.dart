class Car2 {
  int? _id;
  int? _brandId;
  int? _colorId;
  String? _carName;
  int? _modelYear;
  int? _dailyPrice;
  String? _description;
  int? _carFindexPoint;

  int? get id => _id;
  int? get brandId => _brandId;
  int? get colorId => _colorId;
  String? get carName => _carName;
  int? get modelYear => _modelYear;
  int? get dailyPrice => _dailyPrice;
  String? get description => _description;
  int? get carFindexPoint => _carFindexPoint;

  Car2({
      int? id, 
      int? brandId, 
      int? colorId, 
      String? carName, 
      int? modelYear, 
      int? dailyPrice, 
      String? description, 
      int? carFindexPoint}){
    _id = id;
    _brandId = brandId;
    _colorId = colorId;
    _carName = carName;
    _modelYear = modelYear;
    _dailyPrice = dailyPrice;
    _description = description;
    _carFindexPoint = carFindexPoint;
}

  Car2.fromJson(dynamic json) {
    _id = json["id"];
    _brandId = json["brandId"];
    _colorId = json["colorId"];
    _carName = json["carName"];
    _modelYear = json["modelYear"];
    _dailyPrice = json["dailyPrice"];
    _description = json["description"];
    _carFindexPoint = json["carFindexPoint"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["brandId"] = _brandId;
    map["colorId"] = _colorId;
    map["carName"] = _carName;
    map["modelYear"] = _modelYear;
    map["dailyPrice"] = _dailyPrice;
    map["description"] = _description;
    map["carFindexPoint"] = _carFindexPoint;
    return map;
  }

}