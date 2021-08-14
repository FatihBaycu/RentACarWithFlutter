class Token {
  String? token;
  String? expiration;
  Token.withEmpty() {}
  Token({
      this.token, 
      this.expiration});

  Token.fromJson(dynamic json) {
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