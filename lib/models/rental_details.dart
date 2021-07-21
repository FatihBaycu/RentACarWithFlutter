class RentalDetails {
  int? customerId;
  int? userId;
  int? brandId;
  int? colorId;
  int? carId;
  int? rentalId;
  String? firstName;
  String? lastName;
  String? brandName;
  String? colorName;
  String? carName;
  String? rentDate;
  String? returnDate;
  String? imagePath;

  RentalDetails({
      this.customerId, 
      this.userId, 
      this.brandId, 
      this.colorId, 
      this.carId, 
      this.rentalId, 
      this.firstName, 
      this.lastName, 
      this.brandName, 
      this.colorName, 
      this.carName, 
      this.rentDate, 
      this.returnDate,
      this.imagePath});

  RentalDetails.fromJson(dynamic json) {
    this.customerId = ["", null].contains(json['customerId']) ? 0 : json['customerId'];
    this.userId = ["", null].contains(json['userId']) ? 0 : json['userId'];
    this.brandId = ["", null].contains(json['brandId']) ? 0 : json['brandId'];
    this.colorId = ["", null].contains(json['colorId']) ? 0 : json['colorId'];
    this.carId = ["", null].contains(json['carId']) ? 0 : json['carId'];
    this.rentalId = ["", null].contains(json['rentalId']) ? 0 : json['rentalId'];
    this.firstName = ["", null].contains(json['firstName']) ? "null" : json['firstName'];
    this.lastName = ["", null].contains(json['lastName']) ? "null" : json['lastName'];
    this.brandName = ["", null].contains(json['brandName']) ? "null" : json['brandName'];
    this.colorName = ["", null].contains(json['colorName']) ? "null" : json['colorName'];
    this.carName = ["", null].contains(json['carName']) ? "null": json['carName'];
    this.rentDate = ["", null].contains(json['rentDate']) ? "null" : json['rentDate'];
    this.returnDate = ["", null].contains(json['returnDate']) ? "null" : json['returnDate'];
    this.imagePath = ["", null].contains(json['imagePath']) ? "null" : json['imagePath'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["customerId"] = customerId;
    map["userId"] = userId;
    map["brandId"] = brandId;
    map["colorId"] = colorId;
    map["carId"] = carId;
    map["rentalId"] = rentalId;
    map["firstName"] = firstName;
    map["lastName"] = lastName;
    map["brandName"] = brandName;
    map["colorName"] = colorName;
    map["carName"] = carName;
    map["rentDate"] = rentDate;
    map["returnDate"] = returnDate;
    map["imagePath"] = imagePath;
    return map;
  }

}