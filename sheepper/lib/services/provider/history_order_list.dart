import 'package:flutter/foundation.dart';
import 'package:sheepper/models/order.dart';

class HistoryOrderListProvider with ChangeNotifier {
  List<OrderModel> order_list = [];
  bool isLoading = false;

  void updateList(List<OrderModel> list) {
    order_list = list;
    notifyListeners();
  }

  void changeLoadState(bool value) {
    isLoading = value;
    //notifyListeners();
  }
}
