class MyVirtualMachines {
  String? message;
  Data? data;

  MyVirtualMachines({this.message, this.data});

  MyVirtualMachines.fromJson(Map<String, dynamic> json) {
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
  List<InstanceData>? data;
  int? activeOperation;
  Page? page;

  Data({this.data, this.activeOperation, this.page});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <InstanceData>[];
      json['data'].forEach((v) {
        data!.add(new InstanceData.fromJson(v));
      });
    }
    activeOperation = json['active_operation'];
    page = json['page'] != null ? new Page.fromJson(json['page']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['active_operation'] = this.activeOperation;
    if (this.page != null) {
      data['page'] = this.page!.toJson();
    }
    return data;
  }
}

class InstanceData {
  String? uuid;
  String? owner;
  String? ownerEmail;
  String? hostname;
  String? ipAddress;
  int? cpu;
  String? memory;
  String? storage;
  String? status;
  Os? os;
  String? location;
  String? tier;
  double? pricePerHour;
  double? estimatedMonthlyCost;
  double? cost;
  int? operationFlag;
  String? createdAt;

  InstanceData(
      {this.uuid,
      this.owner,
      this.ownerEmail,
      this.hostname,
      this.ipAddress,
      this.cpu,
      this.memory,
      this.storage,
      this.status,
      this.os,
      this.location,
      this.tier,
      this.pricePerHour,
      this.estimatedMonthlyCost,
      this.cost,
      this.operationFlag,
      this.createdAt});

  InstanceData.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    owner = json['owner'];
    ownerEmail = json['owner_email'];
    hostname = json['hostname'];
    ipAddress = json['ip_address'];
    cpu = json['cpu'];
    memory = json['memory'];
    storage = json['storage'];
    status = json['status'];
    os = json['os'] != null ? new Os.fromJson(json['os']) : null;
    location = json['location'];
    tier = json['tier'];
    pricePerHour = json['price_per_hour'];
    estimatedMonthlyCost = json['estimated_monthly_cost'];
    cost = json['cost'];
    operationFlag = json['operation_flag'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['owner'] = this.owner;
    data['owner_email'] = this.ownerEmail;
    data['hostname'] = this.hostname;
    data['ip_address'] = this.ipAddress;
    data['cpu'] = this.cpu;
    data['memory'] = this.memory;
    data['storage'] = this.storage;
    data['status'] = this.status;
    if (this.os != null) {
      data['os'] = this.os!.toJson();
    }
    data['location'] = this.location;
    data['tier'] = this.tier;
    data['price_per_hour'] = this.pricePerHour;
    data['estimated_monthly_cost'] = this.estimatedMonthlyCost;
    data['cost'] = this.cost;
    data['operation_flag'] = this.operationFlag;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Os {
  String? name;
  String? image;

  Os({this.name, this.image});

  Os.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}

class Page {
  int? total;
  int? count;
  int? perPage;
  int? currentPage;
  int? totalPages;

  Page(
      {this.total,
      this.count,
      this.perPage,
      this.currentPage,
      this.totalPages});

  Page.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    count = json['count'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    totalPages = json['total_pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['count'] = this.count;
    data['per_page'] = this.perPage;
    data['current_page'] = this.currentPage;
    data['total_pages'] = this.totalPages;
    return data;
  }
}
