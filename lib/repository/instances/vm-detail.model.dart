class VMDetailModel {
  String? message;
  Data? data;

  VMDetailModel({this.message, this.data});

  VMDetailModel.fromJson(Map<String, dynamic> json) {
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
  String? username;
  String? cpu;
  bool? isCpuDedicated;
  String? memory;
  String? storage;
  String? status;
  String? osName;
  String? ipAddress;
  String? rdns;
  String? privateNetwork;
  int? locationId;
  String? location;
  int? tierId;
  String? tier;
  Os? os;
  double? pricePerHour;
  double? estimatedMonthlyPrice;
  double? cost;
  int? operationFlag;
  String? createdAt;
  String? updatedAt;
  String? lastStartedAt;

  Data(
      {this.uuid,
      this.hostname,
      this.username,
      this.cpu,
      this.isCpuDedicated,
      this.memory,
      this.storage,
      this.status,
      this.osName,
      this.ipAddress,
      this.rdns,
      this.privateNetwork,
      this.locationId,
      this.location,
      this.tierId,
      this.tier,
      this.os,
      this.pricePerHour,
      this.estimatedMonthlyPrice,
      this.cost,
      this.operationFlag,
      this.createdAt,
      this.updatedAt,
      this.lastStartedAt});

  Data.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    hostname = json['hostname'];
    username = json['username'];
    cpu = json['cpu'];
    isCpuDedicated = json['is_cpu_dedicated'];
    memory = json['memory'];
    storage = json['storage'];
    status = json['status'];
    osName = json['os_name'];
    ipAddress = json['ip_address'];
    rdns = json['rdns'];
    privateNetwork = json['private_network'];
    locationId = json['location_id'];
    location = json['location'];
    tierId = json['tier_id'];
    tier = json['tier'];
    os = json['os'] != null ? Os.fromJson(json['os']) : null;
    pricePerHour = json['price_per_hour'];
    estimatedMonthlyPrice = json['estimated_monthly_price'];
    cost = json['cost'];
    operationFlag = json['operation_flag'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    lastStartedAt = json['last_started_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['hostname'] = hostname;
    data['username'] = username;
    data['cpu'] = cpu;
    data['is_cpu_dedicated'] = isCpuDedicated;
    data['memory'] = memory;
    data['storage'] = storage;
    data['status'] = status;
    data['os_name'] = osName;
    data['ip_address'] = ipAddress;
    data['rdns'] = rdns;
    data['private_network'] = privateNetwork;
    data['location_id'] = locationId;
    data['location'] = location;
    data['tier_id'] = tierId;
    data['tier'] = tier;
    if (os != null) {
      data['os'] = os!.toJson();
    }
    data['price_per_hour'] = pricePerHour;
    data['estimated_monthly_price'] = estimatedMonthlyPrice;
    data['cost'] = cost;
    data['operation_flag'] = operationFlag;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['last_started_at'] = lastStartedAt;
    return data;
  }
}

class Os {
  int? templateId;
  String? version;
  int? osId;
  String? name;
  String? image;

  Os({this.templateId, this.version, this.osId, this.name, this.image});

  Os.fromJson(Map<String, dynamic> json) {
    templateId = json['template_id'];
    version = json['version'];
    osId = json['os_id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['template_id'] = templateId;
    data['version'] = version;
    data['os_id'] = osId;
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}
