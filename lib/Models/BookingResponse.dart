class BookingResponse {
  List<Bookings> bookings;

  BookingResponse({this.bookings});

  BookingResponse.fromJson(Map<String, dynamic> json) {
    if (json['bookings'] != null) {
      bookings = new List<Bookings>();
      json['bookings'].forEach((v) {
        bookings.add(new Bookings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bookings != null) {
      data['bookings'] = this.bookings.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Bookings {
  int bookingNumber;
  String name;
  String pitchImage;
  String bookingDate;
  String bookingSlotStartTime;
  String bookingSlotEndTime;
  int total;

  Bookings(
      {this.bookingNumber,
        this.name,
        this.pitchImage,
        this.bookingDate,
        this.bookingSlotStartTime,
        this.bookingSlotEndTime,
        this.total});

  Bookings.fromJson(Map<String, dynamic> json) {
    bookingNumber = json['booking_number'];
    name = json['name'];
    pitchImage = json['pitch_image'];
    bookingDate = json['booking_date'];
    bookingSlotStartTime = json['booking_slot_start_time'];
    bookingSlotEndTime = json['booking_slot_end_time'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booking_number'] = this.bookingNumber;
    data['name'] = this.name;
    data['pitch_image'] = this.pitchImage;
    data['booking_date'] = this.bookingDate;
    data['booking_slot_start_time'] = this.bookingSlotStartTime;
    data['booking_slot_end_time'] = this.bookingSlotEndTime;
    data['total'] = this.total;
    return data;
  }
}
