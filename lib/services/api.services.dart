import 'package:dio/dio.dart';
import 'package:maxcloud/utils/constants.dart';
import 'package:maxcloud/utils/endpoints.dart';

class ApiServices {
  static Dio dio = Dio(BaseOptions(
      baseUrl: Constants.baseUrl,
      responseType: ResponseType.json,
      headers: {
        "Accept": "application/json",
      }));

  static Future<dynamic> login(String email, String password) async {
    try {
      final response = await dio.post(Endpoints.login,
          data: {"email": email, "password": password},
          options: Options(headers: {"x-mobile-token": "=U-wQEy1xn0uBgcy"}));
      return response;
    } on DioException catch (e) {
      print(e.response?.realUri);
      print(e.response);
      return e;
    }
  }

  static Future<dynamic> requestOtp(String credential) async {
    try {
      final response = await dio.post(Endpoints.requestOtp,
          data: {"credential": credential},
          options: Options(headers: {"x-mobile-token": "=U-wQEy1xn0uBgcy"}));
      return response;
    } on DioException catch (e) {
      print(e.response?.realUri);
      print(e.response);
      return e;
    }
  }

  static Future<dynamic> validateOtp(String credential, String code) async {
    try {
      final response = await dio.post(Endpoints.validateOtp,
          data: {"credential": credential, "code": code},
          options: Options(headers: {"x-mobile-token": "=U-wQEy1xn0uBgcy"}));
      return response;
    } on DioException catch (e) {
      print(e.response?.realUri);
      print(e.response);
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
