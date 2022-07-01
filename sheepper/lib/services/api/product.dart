import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:sheepper/models/product.dart';
import 'package:sheepper/models/response/error_response.dart';
import 'package:sheepper/models/response/info_response.dart';
import 'package:sheepper/services/dio.dart';
import 'package:sheepper/services/share_preference.dart';

class ProductApi {
  //Get all products
  static Future<dynamic> getRestaurantInfo() async {
    DioInstance.dio.options.headers["authorization"] =
        "Bearer " + SharePreference.prefs.getString("token").toString();
    final response = await DioInstance.dio.get("/product");
    if (response.statusCode != 200) {
      return ErrorResponse.fromJson(response.data);
    } else {
      return InfoResponse.fromJson(response.data);
    }
  }

  //Get a product
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
  static Future<dynamic> addProductInfo(productOfFood data) async {
    DioInstance.dio.options.headers["authorization"] =
        "Bearer " + SharePreference.prefs.getString("token").toString();

    FormData exteriorPictureFormData = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        data.picture!.path,
        filename: data.picture!.path.split("/").last,
        contentType: MediaType("image", "jpeg"),
      ),
    });

    final exteriorPicture =
        await DioInstance.dio.post("/storage", data: exteriorPictureFormData);
    data.pictureUrl = exteriorPicture.data[0]["url"];

    final response =
        await DioInstance.dio.post("/product/add", data: data.toJson());
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

  static Future<dynamic> updateDoneProduct(String id) async {
    DioInstance.dio.options.headers["authorization"] =
        "Bearer " + SharePreference.prefs.getString("token").toString();
    final response = await DioInstance.dio.patch("/product/done/$id");

    if (response.statusCode != 200) {
      return ErrorResponse.fromJson(response.data);
    } else {
      return InfoResponse.fromJson(response.data);
    }
  }
}
