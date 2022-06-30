import 'package:flutter/foundation.dart';
import 'package:sheepper/models/product.dart';

class UpdateProductOfOrder with ChangeNotifier {
  List<ProductForm1> product = [];

  void updateAmountOfProduct(ProductForm1 newProduct) {
    product.add(newProduct);
    notifyListeners();
  }

  void deleteList() {
    product = [];
    notifyListeners();
  }
}
