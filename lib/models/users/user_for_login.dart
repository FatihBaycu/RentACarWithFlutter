class UserForLogin {
  String? email;
  String? password;

  UserForLogin.withEmpty();
  UserForLogin(this.email, this.password);

  UserForLogin.fromJson(Map json){
    this.email = json["email"];
    this.password = json["password"];
  }


  Map<String, dynamic> toJsonForAdd() {
    return {
      "email": this.email,
      "password": this.password
    };
  }
}