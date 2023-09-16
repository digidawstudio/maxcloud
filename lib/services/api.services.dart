import 'package:dio/dio.dart';

class ApiServices {
  static Dio dio = Dio(BaseOptions(baseUrl: "https://memek.com/"));

  static Future<void> getSomething() async {
    try {
      dio.get("memek", options: Options(headers: {"applications": ""}));
    } on DioException catch (e) {
      print(e.stackTrace);
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
