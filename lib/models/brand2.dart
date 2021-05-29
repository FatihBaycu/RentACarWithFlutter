class Brand2 {
  int? _brandId;
  String? _brandName;

  int? get brandId => _brandId;
  String? get brandName => _brandName;

  Brand2({
      int? brandId, 
      String? brandName}){
    _brandId = brandId;
    _brandName = brandName;
}

  Brand2.fromJson(dynamic json) {
    _brandId = json["brandId"];
    _brandName = json["brandName"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["brandId"] = _brandId;
    map["brandName"] = _brandName;
    return map;
  }

}