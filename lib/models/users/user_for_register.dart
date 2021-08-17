class UserForRegister{
  String? email;
  String? password;
  String? firstName;
  String? lastName;
  String? companyName;

  UserForRegister(this.email, this.password, this.firstName, this.lastName,
      this.companyName);


  UserForRegister.withEmpty();

  UserForRegister.fromJson(Map json){
    this.email=json["email"];
    this.password=json["password"];
    this.firstName=json["firstName"];
    this.lastName=json["lastName"];
    this.companyName=json["companyName"];
  }


  Map<String,dynamic>  toJsonForAdd() {
    return {
      "email": this.email,
      "password": this.password,
      "firstName": this.firstName,
      "lastName": this.lastName,
      "companyName": this.companyName
    };
  }

}