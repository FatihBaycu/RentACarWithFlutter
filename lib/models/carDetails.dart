class CarDetails {
  String? description;
  int? carId;
  String? carName;
  String? brandName;
  int? modelYear;
  String? colorName;
  int? dailyPrice;
  String? imagePath;
  int? brandId;
  int? colorId;
  int? carFindexPoint;


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
      this.carFindexPoint);


  CarDetails.fromJson(dynamic json) {
    this.carId = ["", null].contains(json['carId']) ? 0 : json['carId'];
    this.brandId = ["", null].contains(json['brandId']) ? "null" : json['brandId'];
    this.brandName = ["", null].contains(json['brandName']) ? "null" : json['brandName'];
    this.colorId = ["", null].contains(json['colorId']) ? 0 : json['colorId'];
    this.colorName = ["", null].contains(json['colorName']) ? "null" : json['colorName'];
    this.carName = ["", null].contains(json["carName"]) ? "null" : json['carName'];
    this.modelYear = ["", null].contains(json['modelYear'].toString()) ? 0 : json['modelYear'];
    this.dailyPrice = ["", null].contains(json['dailyPrice']) ? 0 : json['dailyPrice'];
    this.imagePath = ["", null].contains(json['imagePath']) ? "null" : json['imagePath'];
    this.description = ["", null].contains(json['description']) ? "null" : json['description'];
    this.carFindexPoint = ["", null].contains(json['carFindexPoint']) ? 0 : json['carFindexPoint'];

  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["description"] = description;
    map["carId"] = carId;
    map["carName"] =carName;
    map["brandName"] = brandName;
    map["modelYear"] = modelYear;
    map["colorName"] = colorName;
    map["dailyPrice"] =dailyPrice;
    map["imagePath"] = imagePath;
    map["brandId"] = brandId;
    map["colorId"] = colorId;
    map["carFindexPoint"] = carFindexPoint;
    return map;
  }
}