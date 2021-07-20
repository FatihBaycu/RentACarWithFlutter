class Customer{
  int?    customerId;
  int? userId;
  String? companyName;
  int? customerFindexPoint;

  Customer(this.customerId,this.userId,this.companyName,this.customerFindexPoint);

  Customer.fromJson(Map json){
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