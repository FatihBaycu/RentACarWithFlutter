class Color{
  int? colorId;
  String? colorName;
  String? colorCode;

    Color(this.colorId,this.colorName,this.colorCode);
    Color.required({this.colorName,this.colorCode});
    Color.fromJson(Map json){
      this.colorId = ["", null].contains(json['colorId']) ? 0 : json['colorId'];
      this.colorName = ["", null].contains(json['colorName']) ? "null" : json['colorName'];
      this.colorCode = ["", null].contains(json['colorCode']) ? "null" : json['colorCode'];
    }

    Map toJson(){
    Map colorJsonFormat={
      "colorId":this.colorId,
      "colorName":this.colorName,
      "colorCode":this.colorCode,
    };
      return colorJsonFormat;
    }


  Map<String,dynamic> toJsonForAdd(){
    return{
      "colorName":this.colorName,
      "colorCode":this.colorCode,
    };
  }


}