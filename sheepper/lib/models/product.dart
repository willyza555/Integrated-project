class ProductForm {
  final String id;
  final String res_id;
  final String name;
  final int price;

  ProductForm(
      {required this.id,
      required this.res_id,
      required this.name,
      required this.price});

  factory ProductForm.fromJson(Map<String, dynamic> json) {
    return ProductForm(
      id: json['_id'],
      res_id: json['res_id'],
      name: json['name'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'resid': res_id,
      'name': name,
      'price': price,
    };
  }
}
