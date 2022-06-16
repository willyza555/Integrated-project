// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:sheepper/services/constants.dart';

class DioInstance {
  static late Dio dio;
  static void init() async {
    var options = BaseOptions(
      baseUrl: Constants.baseUrl,
      contentType: "application/json",
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    try {
      dio = Dio(options);
      print("Dio is ready");
    } catch (e) {
      print(e);
    }
  }
}
