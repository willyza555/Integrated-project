import 'dart:io';

class ProductForm {
  final String id;
  final String res_id;
  final String name;
  final int price;
  String pictureUrl;
  File? picture;

  ProductForm.set({
    required this.id,
    required this.res_id,
    required this.name,
    required this.price,
    required this.pictureUrl,
    this.picture,
  });

  factory ProductForm.fromJson(Map<String, dynamic> json) {
    return ProductForm.set(
        id: json['_id'],
        res_id: json['res_id'],
        name: json['name'],
        price: json['price'],
        pictureUrl: json['picture_url'],
        picture: null);
  }

  Map<String, dynamic> toJson() {
    return {
      'res_id': res_id,
      'name': name,
      'price': price,
      'picture_url': pictureUrl,
    };
  }
}

class productOfFood {
  String name;
  int price;
  String pictureUrl;
  File? picture;

  productOfFood.set(
      {required this.name,
      required this.price,
      required this.pictureUrl,
      this.picture});

  factory productOfFood.fromJson(Map<String, dynamic> json) {
    return productOfFood.set(
        name: json['name'],
        price: json['price'],
        pictureUrl: json['picture_url'],
        picture: null);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'price': price, 'pictureUrl': pictureUrl};
  }
}

class ProductForm1 {
  final String id;
  final String res_id;
  final String name;
  final int price;
  final bool isSoldOut;
  String pictureUrl;
  File? picture;

  ProductForm1.set(
      {required this.id,
      required this.res_id,
      required this.name,
      required this.price,
      required this.isSoldOut,
      required this.pictureUrl,
      this.picture});

  factory ProductForm1.fromJson(Map<String, dynamic> json) {
    return ProductForm1.set(
        id: json['_id'],
        res_id: json['res_id'],
        name: json['name'],
        price: json['price'],
        isSoldOut: json['isSoldOut'],
        pictureUrl: json['picture_url'],
        picture: null);
  }

  Map<String, dynamic> toJson() {
    return {
      'res_id': res_id,
      'name': name,
      'price': price,
      'isSoldOut': isSoldOut,
      'pictureUrl': pictureUrl
    };
  }
}
