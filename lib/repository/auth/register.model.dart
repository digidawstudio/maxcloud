class RegisterModel {
  String? message;
  Data? data;

  RegisterModel({this.message, this.data});

  RegisterModel.fromJson(Map<String, dynamic> json) {
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
