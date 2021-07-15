class Brand{
  int? brandId;
  String? brandName;

    Brand(this.brandId,this.brandName);
    Brand.required({this.brandName});
    
    Brand.fromJson(Map json){
      this.brandId=json["brandId"];
      this.brandName=json["brandName"];

    }
    Map toJson(){
   var map=<String,dynamic>{
      "brandId":this.brandId,
      "brandName":this.brandName,
    };
      return map;
    }


  Map<String,dynamic> toJsonForAdd(){
    return{
      "brandName":this.brandName,
    };
  }
  Map<String,dynamic> toJsonForUpdate(){
    return{
      "brandId":this.brandId,
      "brandName":this.brandName,
    };
  }
}