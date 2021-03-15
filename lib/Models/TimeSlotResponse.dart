class TimeSlotResponse {
  String bookingDate;
  String pitchName;
  List<Timeslots> timeslots;

  TimeSlotResponse({this.bookingDate, this.pitchName, this.timeslots});

  TimeSlotResponse.fromJson(Map<String, dynamic> json) {
    bookingDate = json['Booking date'];
    pitchName = json['pitch Name'];
    if (json['timeslots'] != null) {
      timeslots = new List<Timeslots>();
      json['timeslots'].forEach((v) {
        timeslots.add(new Timeslots.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Booking date'] = this.bookingDate;
    data['pitch Name'] = this.pitchName;
    if (this.timeslots != null) {
      data['timeslots'] = this.timeslots.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Timeslots {
  String from;
  String to;
  bool isAvailable  = false;
  bool isBooked = false;

  Timeslots({this.from, this.to,this.isAvailable,this.isBooked});

  Timeslots.fromJson(Map<String, dynamic> json) {
    from = json['from'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from'] = this.from;
    data['to'] = this.to;
    return data;
  }
}
