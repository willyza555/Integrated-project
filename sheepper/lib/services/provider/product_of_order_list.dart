import 'package:flutter/foundation.dart';
import 'package:sheepper/models/product.dart';

class UpdateProductOfOrder with ChangeNotifier {
  List<ProductForm> product = [];

  void updateAmountOfProduct(ProductForm newProduct) {
    product.add(newProduct);
    notifyListeners();
  }
}
