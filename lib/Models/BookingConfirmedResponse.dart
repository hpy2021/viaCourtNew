class BookingConfirmedResponse {
  String message;
  Booking booking;
  List<Court> court;

  BookingConfirmedResponse({this.message, this.booking});

  BookingConfirmedResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    booking =
    json['booking'] != null ? new Booking.fromJson(json['booking']) : null;
    if (json['court'] != null) {
      court = new List<Court>();
      json['court'].forEach((v) {
        court.add(new Court.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.booking != null) {
      data['booking'] = this.booking.toJson();
    }
    if (this.court != null) {
      data['court'] = this.court.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Booking {
  String usersId;
  int locationsId;
  int courtsId;
  int pitchId;
  int bookingNumber;
  String bookingDate;
  String bookingSlot;
  String bookingSlotStartTime;
  String bookingSlotEndTime;
  double duration;
  double price;
  String bookingStatus;
  String updatedAt;
  String createdAt;
  int id;

  Booking(
      {this.usersId,
        this.locationsId,
        this.courtsId,
        this.pitchId,
        this.bookingNumber,
        this.bookingDate,
        this.bookingSlot,
        this.bookingSlotStartTime,
        this.bookingSlotEndTime,
        this.duration,
        this.price,
        this.bookingStatus,
        this.updatedAt,
        this.createdAt,
        this.id});

  Booking.fromJson(Map<String, dynamic> json) {
    usersId = json['users_id'];
    locationsId = json['locations_id'];
    courtsId = json['courts_id'];
    pitchId = json['pitch_id'];
    bookingNumber = json['booking_number'];
    bookingDate = json['booking_date'];
    bookingSlot = json['booking_slot'];
    bookingSlotStartTime = json['booking_slot_start_time'];
    bookingSlotEndTime = json['booking_slot_end_time'];
    duration = json['duration'];
    price = json['price'];
    bookingStatus = json['booking_status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['users_id'] = this.usersId;
    data['locations_id'] = this.locationsId;
    data['courts_id'] = this.courtsId;
    data['pitch_id'] = this.pitchId;
    data['booking_number'] = this.bookingNumber;
    data['booking_date'] = this.bookingDate;
    data['booking_slot'] = this.bookingSlot;
    data['booking_slot_start_time'] = this.bookingSlotStartTime;
    data['booking_slot_end_time'] = this.bookingSlotEndTime;
    data['duration'] = this.duration;
    data['price'] = this.price;
    data['booking_status'] = this.bookingStatus;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
class Court {
  String title;

  Court({this.title});

  Court.fromJson(Map<String, dynamic> json) {
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    return data;
  }
}