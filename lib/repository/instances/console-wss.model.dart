class ConsoleWSSModel {
  String? message;
  Data? data;

  ConsoleWSSModel({this.message, this.data});

  ConsoleWSSModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? webview;

  Data({this.webview});

  Data.fromJson(Map<String, dynamic> json) {
    webview = json['webview'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['webview'] = this.webview;
    return data;
  }
}
