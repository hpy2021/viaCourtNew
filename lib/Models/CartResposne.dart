class CartResponse {
  List<ServiceData> service;
  Pitch pitch;

  CartResponse({this.service, this.pitch});

  CartResponse.fromJson(Map<String, dynamic> json) {
    if (json['service'] != null) {
      service = new List<ServiceData>();
      json['service'].forEach((v) {
        service.add(new ServiceData.fromJson(v));
      });
    }
    pitch = json['pitch'] != null ? new Pitch.fromJson(json['pitch']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.service != null) {
      data['service'] = this.service.map((v) => v.toJson()).toList();
    }
    if (this.pitch != null) {
      data['pitch'] = this.pitch.toJson();
    }
    return data;
  }
}

class ServiceData {
  int price;
  int servicesId;
  int id;
  String title;
  int total;
  int qty;
  String image;

  ServiceData({this.id, this.title, this.total, this.qty, this.image,this.servicesId,this.price,});

  ServiceData.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    servicesId = json['services_id'];
    id = json['id'];
    title = json['title'];
    total = json['total'];
    qty = json['qty'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['services_id'] = this.servicesId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['total'] = this.total;
    data['qty'] = this.qty;
    data['image'] = this.image;
    return data;
  }
}

class Pitch {

  int id;
  String name;
  int price;
  String pitchImage;

  Pitch({this.id, this.name, this.price, this.pitchImage });

  Pitch.fromJson(Map<String, dynamic> json) {

    id = json['id'];
    name = json['name'];
    price = json['price'];
    pitchImage = json['pitch_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['pitch_image'] = this.pitchImage;
    return data;
  }
}
