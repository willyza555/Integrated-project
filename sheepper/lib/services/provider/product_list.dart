import 'package:flutter/foundation.dart';
import 'package:sheepper/models/product.dart';

class UpdateProduct with ChangeNotifier {
  late ProductForm product;

  void updateAmountOfProduct(ProductForm newProduct) {
    product = newProduct;
    notifyListeners();
  }
}