class OrderDetailsResponse {
  int status;
  Data data;

  OrderDetailsResponse({this.status, this.data});

  OrderDetailsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int id;
  var cost;
  String created;
  List<OrderDetails> orderDetails;

  Data({this.id, this.cost, this.created, this.orderDetails});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cost = json['cost'];
    created = json['created'];
    if (json['order_details'] != null) {
      orderDetails = new List<OrderDetails>();
      json['order_details'].forEach((v) {
        orderDetails.add(new OrderDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cost'] = this.cost;
    data['created'] = this.created;
    if (this.orderDetails != null) {
      data['order_details'] = this.orderDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderDetails {
  int id;
  int orderId;
  int productId;
  int quantity;
  var total;
  String prodName;
  String prodCatName;
  String prodImage;

  OrderDetails(
      {this.id,
        this.orderId,
        this.productId,
        this.quantity,
        this.total,
        this.prodName,
        this.prodCatName,
        this.prodImage});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    total = json['total'];
    prodName = json['prod_name'];
    prodCatName = json['prod_cat_name'];
    prodImage = json['prod_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['total'] = this.total;
    data['prod_name'] = this.prodName;
    data['prod_cat_name'] = this.prodCatName;
    data['prod_image'] = this.prodImage;
    return data;
  }
}