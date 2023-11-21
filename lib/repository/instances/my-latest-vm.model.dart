import 'package:maxcloud/repository/instances/my-virtual-machines.model.dart';

class LatestVMModel {
  String? message;
  List<InstanceData>? data;

  LatestVMModel({this.message, this.data});

  LatestVMModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <InstanceData>[];
      json['data'].forEach((v) {
        data!.add(InstanceData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
