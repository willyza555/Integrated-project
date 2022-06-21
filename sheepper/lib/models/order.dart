class OrderModel {
  String order_id = "";
  String res_id = "";
  String cus_id = "";
  int total = 0;
  String? rider_id;
  bool isDone = false;

  OrderModel();

  OrderModel.set({
    required this.order_id,
    required this.res_id,
    required this.cus_id,
    required this.total,
    required this.isDone,
    this.rider_id,
  });

  factory OrderModel.fromJson(Map<String, dynamic> data) {
    return OrderModel.set(
        order_id: data['_id'],
        res_id: data['res_id'],
        cus_id: data['customer_id'],
        total: data['total'],
        isDone: data['isDone'],
        rider_id: data['rider_id']);
  }

  Map<String, dynamic> toJson() {
    return {
      'order_id': order_id,
      'res_id': res_id,
      'cus_id': cus_id,
      'total': total,
      'isDone': isDone,
      'rider_id': rider_id,
    };
  }
}

class OrderDetailModel {
  String order_id = "";
  String product_id = "";
  int quantity = 0;

  OrderDetailModel(
      {required String order_id,
      required String product_id,
      required int quantity});

  OrderDetailModel.set({
    required this.order_id,
    required this.product_id,
    required this.quantity,
  });

  factory OrderDetailModel.fromJson(Map<String, dynamic> data) {
    return OrderDetailModel.set(
      order_id: data['order_id'],
      product_id: data['product_id'],
      quantity: data['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order_id': order_id,
      'product_id': product_id,
      'quantity': quantity,
    };
  }
}
