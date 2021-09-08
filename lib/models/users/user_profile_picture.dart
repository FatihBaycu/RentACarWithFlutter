class UserProfiePicture {
  int? id;
  int? userId;
  String? picturePath;

  UserProfiePicture({this.id, this.userId, this.picturePath});

  UserProfiePicture.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    picturePath = json['picturePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['picturePath'] = this.picturePath;
    return data;
  }
}