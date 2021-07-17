import 'dart:convert';

List<Brand> brandFromJson(String str) => List<Brand>.from(json.decode(str).map((x) => Brand.fromJson(x)));


class Brand {
  int? brandId;
  String? brandName;

    Brand(this.brandId,this.brandName);
    Brand.required({this.brandName});
    
    Brand.fromJson(Map json){
      this.brandName = ["", null].contains(json['brandName']) ? "null" : json['brandName'];
      this.brandId = ["", null].contains(json['brandId']) ? 0 : json['brandId'];
    }


    Map<String, dynamic> toJson(){
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