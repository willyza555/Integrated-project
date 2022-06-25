import 'package:sheepper/models/order.dart';
import 'package:flutter/foundation.dart';

class OrderListProvider with ChangeNotifier, DiagnosticableTreeMixin {
  List<Order> orders = [];
  bool isLoading = false;

  void updateList(List<Order> newOrders) {
    orders = newOrders;
    notifyListeners();
  }

  void changeLoadState(bool value) {
    isLoading = value;
    // notifyListeners();
  }
}
