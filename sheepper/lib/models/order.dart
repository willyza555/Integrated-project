class Order {
  final String id;
  final String resid;
  final String cusid;
  final String riderid;
  final int total;
  final bool isDone;
  final String cus_number;
  final String firstname;
  final String lastname;

  Order(
      {required this.id,
      required this.resid,
      required this.cusid,
      required this.riderid,
      required this.total,
      required this.isDone,
      required this.cus_number,
      required this.firstname,
      required this.lastname});

  factory Order.fromJson(Map<String, dynamic> json, Map<String, dynamic> info) {
    return Order(
      id: json['_id'],
      resid: json['res_id'],
      cusid: json['customer_id'],
      riderid: json['rider_id'],
      total: json['total'],
      isDone: json['isDone'],
      cus_number: info['tel'],
      firstname: info['firstname'],
      lastname: info['lastname']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'resid': resid,
      'cusid': cusid,
      'riderid': riderid,
      'total': total,
      'isDone': isDone,

    };
  }
}
