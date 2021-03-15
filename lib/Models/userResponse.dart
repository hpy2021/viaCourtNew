class UserResponse {
  int id;
  String email;
  String emailVerifiedAt;
  String createdAt;
  String updatedAt;
  String firstname;
  String lastname;
  String status;

  UserResponse(
      {this.id,
        this.email,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt,
        this.firstname,
        this.lastname,
        this.status});

  UserResponse.fromJson(Map<String, dynamic> json) {
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
