import 'package:dio/dio.dart';
import 'package:maxcloud/repository/profile/updateprofile.model.dart';
import 'package:maxcloud/utils/constants.dart';
import 'package:maxcloud/utils/endpoints.dart';

enum PlaceType {
  country,
  province,
  city,
  district
}

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

  static Future<dynamic> register(String credential, String password,
      bool tos_agreement, String referral_code) async {
    try {
      final response = await dio.post(Endpoints.register,
          data: {
            "credential": credential,
            "password": password,
            "password_confirmation": password,
            "tos_agreement": tos_agreement,
            "referral_code": referral_code,
            "type": "EMAIL",
            "request_type": "REGISTER"
          },
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

  static Future<dynamic> getMyInstances(String token) async {
    try {
      final response = await dio.get(Endpoints.myInstance,
          options: Options(headers: {
            "x-mobile-token": "=U-wQEy1xn0uBgcy",
            'Authorization': 'Bearer $token'
          }));
      return response;
    } on DioException catch (e) {
      print(e.response?.realUri);
      print(e.response);
      return e;
    }
  }

  static Future<dynamic> getLatestVM(String token) async {
    try {
      final response = await dio.get(Endpoints.myLatestVM,
          options: Options(headers: {
            "x-mobile-token": "=U-wQEy1xn0uBgcy",
            'Authorization': 'Bearer $token'
          }));
      return response;
    } on DioException catch (e) {
      print(e.response?.realUri);
      print(e.response);
      return e;
    }
  }

  static Future<dynamic> getTotalResource(String token) async {
    try {
      final response = await dio.get(Endpoints.getTotalResource,
          options: Options(headers: {
            "x-mobile-token": "=U-wQEy1xn0uBgcy",
            'Authorization': 'Bearer $token'
          }));
      return response;
    } on DioException catch (e) {
      print(e.response?.realUri);
      print(e.response);
      return e;
    }
  }

  static Future<dynamic> getVMDetail(String token, String vmUuid) async {
    try {
      final response = await dio.get(
          Endpoints.getVMDetail + '/$vmUuid' + '/detail',
          options: Options(headers: {
            "x-mobile-token": "=U-wQEy1xn0uBgcy",
            'Authorization': 'Bearer $token'
          }));
      return response;
    } on DioException catch (e) {
      print(e.response?.realUri);
      print(e.response);
      return e;
    }
  }

  static Future<dynamic> getRRDData(
      String token, String vmUuid, String period) async {
    try {
      final response = await dio.get(
          Endpoints.getVMDetail + '/$vmUuid' + '/rrd',
          queryParameters: {"periode": period},
          options: Options(headers: {
            "x-mobile-token": "=U-wQEy1xn0uBgcy",
            'Authorization': 'Bearer $token'
          }));
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

  static Future<dynamic> getCurrentMonthSummary(String accessToken) async {
    try {
      final response = await dio.get(Endpoints.getCurrentMonthSummary,
          options: Options(headers: {
            "Authorization": "Bearer $accessToken",
            "x-mobile-token": "=U-wQEy1xn0uBgcy"
          }));
      return response;
    } on DioException catch (e) {
      print(e.response?.realUri);
      print(e.response);
      return e;
    }
  }

  static Future<dynamic> getProfile(String accessToken) async {
    try {
      final response = await dio.get(Endpoints.getProfile,
          options: Options(headers: {
            "Authorization": "Bearer $accessToken",
            "x-mobile-token": "=U-wQEy1xn0uBgcy"
          }));
      return response;
    } on DioException catch (e) {
      print(e.response?.realUri);
      print(e.response);
      return e;
    }
  }
  
  static Future<dynamic> placesLookup(PlaceType type, {String param = ""}) async {
    try {

      String endpoints = "";

      switch (type) {
        case PlaceType.country:
          endpoints = Endpoints.countryLookup;
          break;
        case PlaceType.province:
          endpoints = Endpoints.provinceLookup;
          break;
        case PlaceType.city:
          endpoints = Endpoints.cityLookup + param;
          break;
        case PlaceType.district:
          endpoints = Endpoints.districtLookup + param;
          break;
      }

      final response = await dio.get(endpoints,
          options: Options(headers: {
            "x-mobile-token": "=U-wQEy1xn0uBgcy"
          }));
      return response;
    } on DioException catch (e) {
      print(e.response?.realUri);
      print(e.response);
      return e;
    }
  }

  static Future<dynamic> updateProfile(
      String accessToken, UpdateProfile body) async {
    try {
      final response = await dio.patch(Endpoints.updateProfile,
          data: body.toJson(),
          options: Options(headers: {
            "Authorization": "Bearer $accessToken",
            "x-mobile-token": "=U-wQEy1xn0uBgcy"
          }));
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
