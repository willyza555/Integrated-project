class ProductForm {
  final String id;
  final String resid;
  final String name;
  final int price;

  ProductForm(
      {required this.id,
      required this.resid,
      required this.name,
      required this.price});

  factory ProductForm.fromJson(Map<String, dynamic> json) {
    return ProductForm(
      id: json['_id'],
      resid: json['resid'],
      name: json['name'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'resid': resid,
      'name': name,
      'price': price,
    };
  }
}
