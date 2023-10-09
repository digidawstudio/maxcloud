import 'package:dio/dio.dart';
import 'package:maxcloud/utils/constants.dart';
import 'package:maxcloud/utils/endpoints.dart';

class ApiServices {
  static Dio dio = Dio(BaseOptions(baseUrl: Constants.baseUrl));

  static Future<dynamic> login() async {
    try {
      final response = await dio.post(Endpoints.login);
      return response;
    } on DioException catch (e) {
      return e;
    }
  }

  static Future<void> setSomething() async {
    try {
      dio.post("memek", options: Options(headers: {"applications": ""}));
    } on DioException catch (e) {
      print(e.stackTrace);
    }
  }
}
