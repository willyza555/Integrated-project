import 'package:sheepper/models/response/error_response.dart';
import 'package:sheepper/models/response/info_response.dart';
import 'package:sheepper/services/dio.dart';

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
}
