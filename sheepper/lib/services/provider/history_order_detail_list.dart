import 'package:sheepper/models/order.dart';
import 'package:flutter/foundation.dart';

class HistoryOrderDetailListProvider
    with ChangeNotifier, DiagnosticableTreeMixin {
  List<OrderDetailModel> orderDetailList = [];
  bool isLoading = true;

  void updateList(List<OrderDetailModel> list) {
    orderDetailList = list;
    notifyListeners();
  }

  void changeLoadState(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
