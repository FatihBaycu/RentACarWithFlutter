class Color{
  int colorId;
  String colorName;
  String colorCode;

    Color(this.colorId,this.colorName,this.colorCode);
    
    Color.fromJson(Map json){
      this.colorId=json["colorId"];
      this.colorName=json["colorName"];
      this.colorCode=json["colorCode"];
    }

    Map toJson(){
    Map colorJsonFormat={
      "colorId":this.colorId,
      "colorName":this.colorName,
      "colorCode":this.colorCode,
    };
      return colorJsonFormat;
    }
}