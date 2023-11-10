class VMStateModel {
  String? message;
  Data? data;

  VMStateModel({this.message, this.data});

  VMStateModel.fromJson(Map<String, dynamic> json) {
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
  String? uuid;
  String? hostname;

  Data({this.uuid, this.hostname});

  Data.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    hostname = json['hostname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['hostname'] = hostname;
    return data;
  }
}
