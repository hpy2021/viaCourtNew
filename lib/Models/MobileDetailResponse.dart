class MobileDetailResponse {
  String message;
  MobileConfiguration mobileConfiguration;

  MobileDetailResponse({this.message, this.mobileConfiguration});

  MobileDetailResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    mobileConfiguration = json['mobile Configuration'] != null
        ? new MobileConfiguration.fromJson(json['mobile Configuration'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.mobileConfiguration != null) {
      data['mobile Configuration'] = this.mobileConfiguration.toJson();
    }
    return data;
  }
}

class MobileConfiguration {
  int id;
  String usersId;
  String plateform;
  String deviceModel;
  String deviceManufacture;
  String deviceToken;
  String createdAt;
  String updatedAt;

  MobileConfiguration(
      {this.id,
        this.usersId,
        this.plateform,
        this.deviceModel,
        this.deviceManufacture,
        this.deviceToken,
        this.createdAt,
        this.updatedAt});

  MobileConfiguration.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    usersId = json['users_id'];
    plateform = json['plateform'];
    deviceModel = json['device_model'];
    deviceManufacture = json['device_manufacture'];
    deviceToken = json['device_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['users_id'] = this.usersId;
    data['plateform'] = this.plateform;
    data['device_model'] = this.deviceModel;
    data['device_manufacture'] = this.deviceManufacture;
    data['device_token'] = this.deviceToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
