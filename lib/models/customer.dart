class User{
  int?    customerId;
  int? userId;
  String? companyName;
  int? customerFindexPoint;

    User(this.customerId,this.userId,this.companyName,this.customerFindexPoint);
    
    User.fromJson(Map json){
      this.customerId=json["customerId"];
      this.userId=json["userId"];
      this.companyName=json["companyName"];
      this.customerFindexPoint=json["customerFindexPoint"];
    }

    Map toJson(){
    Map customerJsonFormat={
      "customerId":this.customerId,
      "userId":this.userId,
      "companyName":this.companyName,
      "customerFindexPoint":this.customerFindexPoint
    };
      return customerJsonFormat;
    }
}