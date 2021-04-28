class User{
  int id;
  String firstName;
  String lastName;
  String email;
  String passwordHash;
  String passwordSalt;
  bool status;
  
    User(this.id,this.firstName,this.lastName,this.email,this.passwordHash,this.passwordSalt,this.status);
    
    User.fromJson(Map json){
      this.id=json["id"];
      this.firstName=json["firstName"];
      this.lastName=json["lastName"];
      this.email=json["email"];
      this.passwordHash=json["passwordHash"];
      this.passwordHash=json["passwordHash"];
      this.status=json["status"];
    }

    Map toJson(){
    Map userJsonFormat={
      "id":this.id,
      "firstName":this.firstName,
      "lastName":this.lastName,
      "email":this.email,
      "passwordHash":this.passwordHash,
      "passwordSalt":this.passwordSalt,
      "status":this.status
    };
      return userJsonFormat;
    }
}