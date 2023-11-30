import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maxcloud/repository/profile/updateprofile.model.dart';
import 'package:maxcloud/utils/constants.dart';
import 'package:maxcloud/utils/endpoints.dart';

enum PlaceType { country, province, city, district }

class ApiServices {
  static Dio dio = Dio(BaseOptions(
      baseUrl: Constants.baseUrl,
      responseType: ResponseType.json,
      headers: {
        "Accept": "application/json",
        "x-mobile-token": Constants.xMobileToken
      }));

  static Future<dynamic> login(String email, String password) async {
    try {
      final response = await dio.post(
        Endpoints.login,
        data: {"email": email, "password": password},
      );
      return response;
    } on DioException catch (e) {
      print(e.response?.realUri);
      print(e.response);
      return e;
    }
  }

  static Future<dynamic> register(String credential, String password,
      bool tosAgreement, String referralCode) async {
    try {
      final response = await dio.post(
        Endpoints.register,
        data: {
          "credential": credential,
          "password": password,
          "password_confirmation": password,
          "tos_agreement": tosAgreement,
          "referral_code": referralCode,
          "type": "EMAIL",
          "request_type": "REGISTER"
        },
      );
      return response;
    } on DioException catch (e) {
      print(e.response?.realUri);
      print(e.response);
      return e;
    }
  }

  static Future<dynamic> requestOtp(String credential) async {
    try {
      final response = await dio.post(
        Endpoints.requestOtp,
        data: {"credential": credential},
      );
      return response;
    } on DioException catch (e) {
      print(e.response?.realUri);
      print(e.response);
      return e;
    }
  }

  static Future<dynamic> getMyInstances(
      String token, String status, String sort, int limit, int page) async {
    try {
      final response = await dio.get(Endpoints.myInstance,
          queryParameters: {
            "limit": limit,
            "page": page,
            "statuses": status,
            "sort": sort
          },
          options: Options(headers: {'Authorization': 'Bearer $token'}));
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
          options: Options(headers: {'Authorization': 'Bearer $token'}));
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
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      return response;
    } on DioException catch (e) {
      print(e.response?.realUri);
      print(e.response);
      return e;
    }
  }

  static Future<dynamic> getVMDetail(String token, String vmUuid) async {
    try {
      final response = await dio.get('${Endpoints.getVMDetail}/$vmUuid/detail',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
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
      final response = await dio.get('${Endpoints.getVMDetail}/$vmUuid/rrd',
          queryParameters: {"periode": period},
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      return response;
    } on DioException catch (e) {
      print(e.response?.realUri);
      print(e.response);
      return e;
    }
  }

  static Future<dynamic> validateOtp(
      String credential, String code, String fcmToken) async {
    try {
      final response = await dio.post(
        Endpoints.validateOtp,
        data: {"credential": credential, "code": code, "fcm_token": fcmToken},
      );
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
          }));
      return response;
    } on DioException catch (e) {
      print(e.response?.realUri);
      print(e.response);
      return e;
    }
  }

  static Future<dynamic> placesLookup(PlaceType type,
      {String param = ""}) async {
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

      final response = await dio.get(
        endpoints,
      );
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
          }));
      return response;
    } on DioException catch (e) {
      print(e.response?.realUri);
      print(e.response);
      return e;
    }
  }

  static Future<dynamic> getNotifications(
      String accessToken, String type, int page, int limit) async {
    try {
      final response = await dio.get(Endpoints.getNotifications,
          queryParameters: {"type": type, "page": page, "limit": limit},
          options: Options(headers: {
            "Authorization": "Bearer $accessToken",
          }));
      return response;
    } on DioException catch (e) {
      print(e.response?.realUri);
      print(e.response);
      return e;
    }
  }

  static Future<dynamic> getPaymentMethods(
      String accessToken, int amount) async {
    try {
      final response = await dio.get(Endpoints.getPaymentMethods,
          queryParameters: {"amount": amount},
          options: Options(headers: {
            "Authorization": "Bearer $accessToken",
          }));
      return response;
    } on DioException catch (e) {
      print(e.response?.realUri);
      print(e.response);
      return e;
    }
  }

  static Future<dynamic> startVMState(String accessToken, String vmUuid) async {
    try {
      final response =
          await dio.patch(Endpoints.getVMDetail + '/$vmUuid' + '/start',
              options: Options(headers: {
                "Authorization": "Bearer $accessToken",
              }));
      return response;
    } on DioException catch (e) {
      print(e.response?.realUri);
      print(e.response);
      return e;
    }
  }

  static Future<dynamic> restartVMState(
      String accessToken, String vmUuid) async {
    try {
      final response =
          await dio.patch(Endpoints.getVMDetail + '/$vmUuid' + '/restart',
              options: Options(headers: {
                "Authorization": "Bearer $accessToken",
              }));
      return response;
    } on DioException catch (e) {
      print(e.response?.realUri);
      print(e.response);
      return e;
    }
  }

  static Future<dynamic> shutdownVMState(
      String accessToken, String vmUuid) async {
    try {
      final response =
          await dio.patch(Endpoints.getVMDetail + '/$vmUuid' + '/stop',
              options: Options(headers: {
                "Authorization": "Bearer $accessToken",
              }));
      return response;
    } on DioException catch (e) {
      print(e.response?.realUri);
      print(e.response);
      return e;
    }
  }

  static Future<dynamic> createInvoice(String accessToken, dynamic body) async {
    try {
      final response = await dio.post(Endpoints.createInvoice,
          data: body,
          options: Options(headers: {
            "Authorization": "Bearer $accessToken",
          }));
      return response;
    } on DioException catch (e) {
      print(e.response?.realUri);
      print(e.response);
      return e;
    }
  }

  static Future<dynamic> getDepositHistory(
      String accessToken, int page, int limit) async {
    try {
      final response = await dio.get(Endpoints.getDepositHistory,
          queryParameters: {"page": page, "limit": limit},
          options: Options(headers: {
            "Authorization": "Bearer $accessToken",
          }));
      return response;
    } on DioException catch (e) {
      print(e.response?.realUri);
      print(e.response);
      return e;
    }
  }

  static Future<dynamic> changePassword(
      String accessToken, dynamic body) async {
    try {
      final response = await dio.patch(Endpoints.changePassword,
          data: body,
          options: Options(headers: {
            "Authorization": "Bearer $accessToken",
          }));
      return response;
    } on DioException catch (e) {
      print(e.response?.realUri);
      print(e.response);
      return e;
    }
  }

  static Future<dynamic> fetchHelpDeskItems(String accessToken,
      {int page = 1}) async {
    try {
      final response =
          await dio.get("${Endpoints.helpDeskItems}?limit=10&page=$page",
              options: Options(headers: {
                "Authorization": "Bearer $accessToken",
              }));
      return response;
    } on DioException catch (e) {
      print(e.response?.realUri);
      print(e.response);
      return e;
    }
  }

  static Future<dynamic> fetchConversations(
      String accessToken, String convToken,
      {int page = 1}) async {
    try {
      final response = await dio.get(
          "${Endpoints.ticketConversation}/$convToken/conversations?limit=10&page=$page",
          options: Options(headers: {
            "Authorization": "Bearer $accessToken",
          }));
      return response;
    } on DioException catch (e) {
      print(e.response?.realUri);
      print(e.response);
      return e;
    }
  }

  static Future<dynamic> sendMessage(
      String accessToken, String convToken, String message,
      {List<XFile> attachments = const []}) async {
    try {
      FormData data = FormData.fromMap({"content": message});

      for (int i = 0; i < attachments.length; i++) {
        data.files.add(MapEntry("attachments[$i]",
            await MultipartFile.fromFile(attachments[i].path)));
        // data["attachments[$i]"] = attachments[i];
      }

      print(data);

      final response =
          await dio.post("${Endpoints.ticketConversation}/$convToken/reply",
              data: data,
              options: Options(headers: {
                "Authorization": "Bearer $accessToken",
              }));
      return response;
    } on DioException catch (e) {
      print(e.response?.realUri);
      print(e.response);
      return e;
    }
  }

  static Future<dynamic> createNewTicket(
      String accessToken, String message, String subject, String department,
      {List<XFile> attachments = const [],
      String? serviceType,
      String? serviceId}) async {
    try {
      FormData data = FormData.fromMap({
        "content": message,
        "subject": subject,
        "department": department,
      });

      if (serviceType != null) {
        data.fields.add(MapEntry("service_type", serviceType));
      }

      if (serviceId != null) {
        data.fields.add(MapEntry("service_id", serviceId));
      }

      for (int i = 0; i < attachments.length; i++) {
        data.files.add(MapEntry("attachments[$i]",
            await MultipartFile.fromFile(attachments[i].path)));
      }

      print(data);

      final response = await dio.post(Endpoints.createTicket,
          data: data,
          options: Options(headers: {
            "Authorization": "Bearer $accessToken",
          }));
      return response;
    } on DioException catch (e) {
      print(e.response?.realUri);
      print(e.response);
      return e;
    }
  }

  static Future<dynamic> readAllNotifications(String accessToken) async {
    try {
      final response = await dio.patch(Endpoints.readAllNotifications,
          options: Options(headers: {
            "Authorization": "Bearer $accessToken",
          }));
      return response;
    } on DioException catch (e) {
      print(e.response?.realUri);
      print(e.response);
      return e;
    }
  }

  static Future<dynamic> logout(String accessToken) async {
    try {
      final response = await dio.post(Endpoints.logout,
          options: Options(headers: {
            "Authorization": "Bearer $accessToken",
          }));
      return response;
    } on DioException catch (e) {
      print(e.response?.realUri);
      print(e.response);
      return e;
    }
  }

  static Future<dynamic> getDepositDetail(
      String accessToken, String invoiceId) async {
    try {
      final response =
          await dio.get(Endpoints.getDepositDetail + '/$invoiceId' + '/details',
              options: Options(headers: {
                "Authorization": "Bearer $accessToken",
              }));
      return response;
    } on DioException catch (e) {
      print(e.response?.realUri);
      print(e.response);
      return e;
    }
  }

  static Future<dynamic> getConsolewWSS(
      String accessToken, String vmUuid) async {
    try {
      final response = await dio.post(
          Endpoints.getVMDetail + '/$vmUuid' + '/console-websocket',
          options: Options(headers: {
            "Authorization": "Bearer $accessToken",
          }));
      return response;
    } on DioException catch (e) {
      print(e.response?.realUri);
      print(e.response);
      return e;
    }
  }
}
