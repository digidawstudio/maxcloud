class TotalResourceModel {
  String? message;
  Data? data;

  TotalResourceModel({this.message, this.data});

  TotalResourceModel.fromJson(Map<String, dynamic> json) {
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
  int? totalResource;
  int? totalRunning;
  int? totalStopped;

  Data({this.totalResource, this.totalRunning, this.totalStopped});

  Data.fromJson(Map<String, dynamic> json) {
    totalResource = json['total_resource'];
    totalRunning = json['total_running'];
    totalStopped = json['total_stopped'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_resource'] = totalResource;
    data['total_running'] = totalRunning;
    data['total_stopped'] = totalStopped;
    return data;
  }
}
