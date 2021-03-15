class PitchesResponse {
  int status;
  List<PitchData> result;

  PitchesResponse({this.status, this.result});

  PitchesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != null) {
      result =  [];
      json['result'].forEach((v) {
        result.add(new PitchData.fromJson(v));
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

// class PitchData {
//   int id;
//   String name;
//   String size;
//   String availableDays;
//   String title;
//   int price;
//   String slotDurationStartTime;
//   String slotDurationEndTime;
//   int sloteDuration;
//   String pitchImage;
//
//   PitchData(
//       {this.id,
//         this.name,
//         this.size,
//         this.availableDays,
//         this.title,
//         this.price,
//         this.slotDurationStartTime,
//         this.slotDurationEndTime,
//         this.sloteDuration,
//         this.pitchImage});
//
//   PitchData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     size = json['size'];
//     availableDays = json['available_days'];
//     title = json['title'];
//     price = json['price'];
//     slotDurationStartTime = json['slot_duration_start_time'];
//     slotDurationEndTime = json['slot_duration_end_time'];
//     sloteDuration = json['slote_duration'];
//     pitchImage = json['pitch_image'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['size'] = this.size;
//     data['available_days'] = this.availableDays;
//     data['title'] = this.title;
//     data['price'] = this.price;
//     data['slot_duration_start_time'] = this.slotDurationStartTime;
//     data['slot_duration_end_time'] = this.slotDurationEndTime;
//     data['slote_duration'] = this.sloteDuration;
//     data['pitch_image'] = this.pitchImage;
//     return data;
//   }
// }
class PitchData {
  int id;
  String size;
  String availableDays;
  int price;
  int courtsId;

  PitchData({this.id, this.size, this.availableDays, this.price, this.courtsId});

  PitchData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    size = json['size'];
    availableDays = json['available_days'];
    price = json['price'];
    courtsId = json['courts_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['size'] = this.size;
    data['available_days'] = this.availableDays;
    data['price'] = this.price;
    data['courts_id'] = this.courtsId;
    return data;
  }
}