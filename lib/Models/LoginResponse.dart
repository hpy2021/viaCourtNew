class LoginResponse {
  User user;
  int status;
  String token;
  Errors errors;

  LoginResponse({this.user, this.status, this.token});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    status = json['status'];
    token = json['token'];
    errors =
    json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['status'] = this.status;
    data['token'] = this.token;
    if (this.errors != null) {
      data['errors'] = this.errors.toJson();
    }
    return data;
  }
}

class User {
  int id;
  String email;
  String emailVerifiedAt;
  String createdAt;
  String updatedAt;
  String firstname;
  String lastname;
  String status;

  User(
      {this.id,
        this.email,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt,
        this.firstname,
        this.lastname,
        this.status});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['status'] = this.status;
    return data;
  }

}

class Errors {
  List<String> email;

  Errors({this.email});

  Errors.fromJson(Map<String, dynamic> json) {
    email = json['email'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    return data;
  }
}