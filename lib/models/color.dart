class User{
  int colorId;
  String colorName;
  String colorCode;

    User(this.colorId,this.colorName,this.colorCode);
    
    User.fromJson(Map json){
      this.colorId=json["colorId"];
      this.colorName=json["colorName"];
      this.colorCode=json["last_name"];
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