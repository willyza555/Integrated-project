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

class productOfFood{
  String name;
  int price;

  productOfFood({
    required this.name,
    required this.price,
  });

  factory productOfFood.fromJson(Map<String, dynamic> json) {
    return productOfFood(
      name: json['name'],
      price: json['price'],
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'name': name,
      'price': price,
    };
  }

}

class ProductForm1 {
  final String id;
  final String resid;
  final String name;
  final int price;
  final bool isSoldOut;

  ProductForm1(
      {required this.id,
      required this.resid,
      required this.name,
      required this.price,
      required this.isSoldOut});

  factory ProductForm1.fromJson(Map<String, dynamic> json) {
    return ProductForm1(
      id: json['_id'],
      resid: json['res_id'],
      name: json['name'],
      price: json['price'],
      isSoldOut: json['isSoldOut']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'resid': resid,
      'name': name,
      'price': price,
      'isSoldOut': isSoldOut,
    };
  }
}
