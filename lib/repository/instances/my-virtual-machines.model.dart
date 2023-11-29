class MyVirtualMachines {
  String? message;
  Data? data;

  MyVirtualMachines({this.message, this.data});

  MyVirtualMachines.fromJson(Map<String, dynamic> json) {
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
  List<InstanceData>? data;
  int? activeOperation;
  Page? page;

  Data({this.data, this.activeOperation, this.page});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <InstanceData>[];
      json['data'].forEach((v) {
        data!.add(InstanceData.fromJson(v));
      });
    }
    activeOperation = json['active_operation'];
    page = json['page'] != null ? Page.fromJson(json['page']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['active_operation'] = activeOperation;
    if (page != null) {
      data['page'] = page!.toJson();
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
    os = json['os'] != null ? Os.fromJson(json['os']) : null;
    location = json['location'];
    tier = json['tier'];
    pricePerHour = json['price_per_hour'] != null
        ? json['price_per_hour'].toDouble()
        : null;
    estimatedMonthlyCost = json['estimated_monthly_cost'] != null
        ? json['estimated_monthly_cost'].toDouble()
        : null;
    cost = json['cost'];
    operationFlag = json['operation_flag'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['owner'] = owner;
    data['owner_email'] = ownerEmail;
    data['hostname'] = hostname;
    data['ip_address'] = ipAddress;
    data['cpu'] = cpu;
    data['memory'] = memory;
    data['storage'] = storage;
    data['status'] = status;
    if (os != null) {
      data['os'] = os!.toJson();
    }
    data['location'] = location;
    data['tier'] = tier;
    data['price_per_hour'] = pricePerHour;
    data['estimated_monthly_cost'] = estimatedMonthlyCost;
    data['cost'] = cost;
    data['operation_flag'] = operationFlag;
    data['created_at'] = createdAt;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['count'] = count;
    data['per_page'] = perPage;
    data['current_page'] = currentPage;
    data['total_pages'] = totalPages;
    return data;
  }
}
