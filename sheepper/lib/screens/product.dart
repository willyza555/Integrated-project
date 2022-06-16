import 'package:flutter/material.dart';

class Product extends StatefulWidget {
  const Product({Key? key, this.args}) : super(key: key);
  final Map<String, dynamic>? args;
  static const routeName = "/product";

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
