import 'package:sheepper/models/product.dart';
import 'package:sheepper/models/response/error_response.dart';
import 'package:sheepper/models/response/info_response.dart';
import 'package:sheepper/services/dio.dart';
import 'package:sheepper/services/share_preference.dart';

class ProductApi {
  //Get all products
  static Future<dynamic> getProductInfo(String id) async {
    DioInstance.dio.options.headers["authorization"] =
        "Bearer " + SharePreference.prefs.getString("token").toString();
    final response = await DioInstance.dio.get("/product/$id");
    if (response.statusCode != 200) {
      return ErrorResponse.fromJson(response.data);
    } else {
      return InfoResponse.fromJson(response.data);
    }
  }

  //Add new product
  static Future<dynamic> addProductInfo(ProductForm data) async {
    DioInstance.dio.options.headers["authorization"] =
        "Bearer " + SharePreference.prefs.getString("token").toString();
    final response =
        await DioInstance.dio.post("/product", data: data.toJson());

    if (response.statusCode != 200) {
      return ErrorResponse.fromJson(response.data);
    } else {
      return InfoResponse.fromJson(response.data);
    }
  }

  //Update product
  static Future<dynamic> updateProductInfo(ProductForm data, String id) async {
    DioInstance.dio.options.headers["authorization"] =
        "Bearer " + SharePreference.prefs.getString("token").toString();
    final response =
        await DioInstance.dio.patch("/product/$id", data: data.toJson());

    if (response.statusCode != 200) {
      return ErrorResponse.fromJson(response.data);
    } else {
      return InfoResponse.fromJson(response.data);
    }
  }

  //Delete product
  static Future<dynamic> deleteProductInfo(String id) async {
    DioInstance.dio.options.headers["authorization"] =
        "Bearer " + SharePreference.prefs.getString("token").toString();
    final response = await DioInstance.dio.delete("/product/$id");

    if (response.statusCode != 200) {
      return ErrorResponse.fromJson(response.data);
    } else {
      return InfoResponse.fromJson(response.data);
    }
  }
}
