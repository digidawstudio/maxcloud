class OtpModel {
  String? message;
  Data? data;

  OtpModel({this.message, this.data});

  OtpModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? credential;
  String? requestType;

  Data({this.credential, this.requestType});

  Data.fromJson(Map<String, dynamic> json) {
    credential = json['credential'];
    requestType = json['request_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['credential'] = credential;
    data['request_type'] = requestType;
    return data;
  }
}

class OtpValidate {
  String? message;
  OtpValidateData? data;

  OtpValidate({this.message, this.data});

  OtpValidate.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? OtpValidateData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class OtpValidateData {
  String? accessToken;
  String? customer;

  OtpValidateData({this.accessToken, this.customer});

  OtpValidateData.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    customer = json['customer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['customer'] = customer;
    return data;
  }
}

