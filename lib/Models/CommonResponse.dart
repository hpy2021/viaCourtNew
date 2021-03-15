class CommonResponse {
  int status;
  String message;
  String result;

  CommonResponse({ this.status, this.message});

  CommonResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['name'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['name'] = this.message;
    data['result'] = this.result;
    return data;
  }
}
