class UserDetail {
  int? customerId;
  int? userId;
  String? companyName;
  String? firstName;
  String? lastName;
  String? email;
  bool? status;
  int? customerFindexPoint;

  UserDetail.withEmpty();

  UserDetail({
      this.customerId, 
      this.userId, 
      this.companyName, 
      this.firstName, 
      this.lastName, 
      this.email, 
      this.status, 
      this.customerFindexPoint});

  UserDetail.fromJson(dynamic json) {
    customerId = json["customerId"];
    userId = json["userId"];
    companyName = json["companyName"];
    firstName = json["firstName"];
    lastName = json["lastName"];
    email = json["email"];
    status = json["status"];
    customerFindexPoint = json["customerFindexPoint"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["customerId"] = customerId;
    map["userId"] = userId;
    map["companyName"] = companyName;
    map["firstName"] = firstName;
    map["lastName"] = lastName;
    map["email"] = email;
    map["status"] = status;
    map["customerFindexPoint"] = customerFindexPoint;
    return map;
  }

}