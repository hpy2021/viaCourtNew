class AddToCartresponse {
  String message;
  Product product;

  AddToCartresponse({this.message, this.product});

  AddToCartresponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    return data;
  }
}

class Product {
  int bookingsId;
  int servicesId;
  int usersId;
  int price;
  int qty;
  int total;
  String status;
  int id;

  Product(
      {this.bookingsId,
        this.servicesId,
        this.usersId,
        this.price,
        this.qty,
        this.total,
        this.status,this.id});

  Product.fromJson(Map<String, dynamic> json) {
    bookingsId = json['bookings_id'];
    servicesId = json['services_id'];
    usersId = json['users_id'];
    price = json['price'];
    qty = json['qty'];
    total = json['total'];
    status = json['status'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookings_id'] = this.bookingsId;
    data['services_id'] = this.servicesId;
    data['users_id'] = this.usersId;
    data['price'] = this.price;
    data['qty'] = this.qty;
    data['total'] = this.total;
    data['status'] = this.status;
    data['id'] = this.id;
    return data;
  }
}
