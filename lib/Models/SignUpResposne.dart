class SignUpResponse {
  String csrf;
  User user;
  int status;
  String message;
  Errors errors;


  SignUpResponse({this.status, this.csrf, this.user,this.message,this.errors});

  SignUpResponse.fromJson(Map<String, dynamic> json) {
    csrf = json['csrf'];
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    status = json['status'];
    errors =
    json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['csrf'] = this.csrf;
    data['message'] = this.message;
    data['status'] = this.status;

    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.errors != null) {
      data['errors'] = this.errors.toJson();
    }
    return data;
  }
}

class User {
  String firstname;
  String lastname;
  String email;
  String updatedAt;
  String createdAt;
  int id;

  User(
      {this.firstname,
      this.lastname,
      this.email,
      this.updatedAt,
      this.createdAt,
      this.id});

  User.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
class Errors {
  List<String> email;
  List<String> password;

  Errors({this.email,this.password});

  Errors.fromJson(Map<String, dynamic> json) {
    // email = json['email'].cast<String>();
    email = json["email"] != null ? List.from(json['email']):null;
    password = json["password"] != null ? List.from(json['password']):null;
    // password = json['password'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}