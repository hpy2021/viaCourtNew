class CourtListResponse {
  int status;
  List<CourtData> result;

  CourtListResponse({this.status, this.result});

  CourtListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != null) {
      result = new List<CourtData>();
      json['result'].forEach((v) {
        result.add(new CourtData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CourtData {
  int id;
  String title;
  int price;
  String address1;
  String address2;
  String city;
  String state;
  String country;
  int courtsId;
  String courtImage;
  int locationsId;
  String slotDurationStartTime;
  String slotDurationEndTime;

  CourtData(
      {
        this.id,
        this.title,
        this.price,
        this.address1,
        this.address2,
        this.courtsId,
        this.city,
        this.state,
        this.country,
        this.slotDurationStartTime,
        this.slotDurationEndTime,
        this.courtImage,
        this.locationsId});

  CourtData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    address1 = json['address1'];
    address2 = json['address2'];
    courtsId = json['courts_id'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    courtImage = json['court_image'];
    locationsId = json['locations_id'];
    slotDurationStartTime = json['slot_duration_start_time'];
    slotDurationEndTime = json['slot_duration_end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] =  this.id;
    data['title'] = this.title;
    data['price'] = this.price;
    data['courts_id'] = this.courtsId;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['court_image'] = this.courtImage;
    data['locations_id'] = this.locationsId;
    data['slot_duration_start_time'] = this.slotDurationStartTime;
    data['slot_duration_end_time'] = this.slotDurationEndTime;
    return data;
  }
}
