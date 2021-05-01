class Brand{
  int brandId;
  String brandName;

    Brand(this.brandId,this.brandName);
    
    Brand.fromJson(Map json){
      this.brandId=int.tryParse(json["brandId"].toString());
      this.brandName=json["brandName"];

    }

    Map toJson(){
    Map brandJsonFormat={
      "brandId":this.brandId,
      "brandName":this.brandName,
    };
      return brandJsonFormat;
    }
}