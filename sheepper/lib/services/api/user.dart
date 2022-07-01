import 'package:sheepper/models/response/error_response.dart';
import 'package:sheepper/models/response/info_response.dart';
import 'package:sheepper/services/dio.dart';
import 'package:sheepper/services/share_preference.dart';

class UserApi {
  static Future<dynamic> login(String email, String password) async {
    var response = await DioInstance.dio.post("/user/signin", data: {
      "email": email,
      "password": password,
    });
    if (response.statusCode != 200) {
      return ErrorResponse.fromJson(response.data);
    }
    return InfoResponse.fromJson(response.data);
  }

  static Future<dynamic> getRestaurantInfo() async {
    DioInstance.dio.options.headers["authorization"] =
        "Bearer " + SharePreference.prefs.getString("token").toString();
    final response = await DioInstance.dio.get("/restaurant");

    if (response.statusCode != 200) {
      return ErrorResponse.fromJson(response.data);
    } else {
      return InfoResponse.fromJson(response.data);
    }
  }

  static Future<dynamic> closAndOpen() async {
    DioInstance.dio.options.headers["authorization"] =
        "Bearer " + SharePreference.prefs.getString("token").toString();
    final response = await DioInstance.dio.patch("/restaurant/close");

    if (response.statusCode != 200) {
      return ErrorResponse.fromJson(response.data);
    } else {
      return InfoResponse.fromJson(response.data);
    }
  }
}
