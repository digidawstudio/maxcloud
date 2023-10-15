import 'package:dio/dio.dart';
import 'package:maxcloud/utils/constants.dart';
import 'package:maxcloud/utils/endpoints.dart';

class ApiServices {
  static Dio dio = Dio(BaseOptions(baseUrl: Constants.baseUrl));

  static Future<dynamic> login() async {
    try {
      var data = {"email": "fachrw@gmail.com", "password": "Nate0023@"};
      final response = await dio.post(Endpoints.login, data: data);
      return response;
    } on DioException catch (e) {
      print(e);
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
