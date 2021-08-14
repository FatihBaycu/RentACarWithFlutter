class Data {
  String? token;
  String? expiration;

  Data({
      this.token, 
      this.expiration});

  Data.fromJson(dynamic json) {
    token = json["token"];
    expiration = json["expiration"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["token"] = token;
    map["expiration"] = expiration;
    return map;
  }

}