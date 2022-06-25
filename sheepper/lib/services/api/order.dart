import 'package:sheepper/models/order.dart';
import 'package:sheepper/models/response/error_response.dart';
import 'package:sheepper/models/response/info_response.dart';
import 'package:sheepper/services/dio.dart';
import 'package:sheepper/services/share_preference.dart';

class OrderApi {
  static Future<dynamic> getBigOrder() async {
    DioInstance.dio.options.headers["authorization"] =
        "Bearer " + SharePreference.prefs.getString("token").toString();
    final response = await DioInstance.dio.get("/order");
    if (response.statusCode != 200) {
      return ErrorResponse.fromJson(response.data);
    } else {
      return InfoResponse.fromJson(response.data);
    }
  }

  static Future<dynamic> getBigHistoryOrder() async {
    DioInstance.dio.options.headers["authorization"] =
        "Bearer " + SharePreference.prefs.getString("token").toString();
    final response = await DioInstance.dio.get("/order/history");
    if (response.statusCode != 200) {
      return ErrorResponse.fromJson(response.data);
    } else {
      return InfoResponse.fromJson(response.data);
    }
  }
}
