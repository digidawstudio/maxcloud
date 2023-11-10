class RRDModel {
  String? message;
  Data? data;

  RRDModel({this.message, this.data});

  RRDModel.fromJson(Map<String, dynamic> json) {
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
  List<Cpu>? cpu;
  List<Memory>? memory;
  List<Network>? network;
  List<Disk>? disk;

  Data({this.cpu, this.memory, this.network, this.disk});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['cpu'] != null) {
      cpu = <Cpu>[];
      json['cpu'].forEach((v) {
        cpu!.add(new Cpu.fromJson(v));
      });
    }
    if (json['memory'] != null) {
      memory = <Memory>[];
      json['memory'].forEach((v) {
        memory!.add(new Memory.fromJson(v));
      });
    }
    if (json['network'] != null) {
      network = <Network>[];
      json['network'].forEach((v) {
        network!.add(new Network.fromJson(v));
      });
    }
    if (json['disk'] != null) {
      disk = <Disk>[];
      json['disk'].forEach((v) {
        disk!.add(new Disk.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cpu != null) {
      data['cpu'] = this.cpu!.map((v) => v.toJson()).toList();
    }
    if (this.memory != null) {
      data['memory'] = this.memory!.map((v) => v.toJson()).toList();
    }
    if (this.network != null) {
      data['network'] = this.network!.map((v) => v.toJson()).toList();
    }
    if (this.disk != null) {
      data['disk'] = this.disk!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cpu {
  String? time;
  double? cpu;

  Cpu({this.time, this.cpu});

  Cpu.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    cpu = double.parse(json['cpu'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['cpu'] = this.cpu;
    return data;
  }
}

class Memory {
  String? time;
  double? rawMaxMemory;
  String? maxMemory;
  double? rawUsageMemory;
  String? usageMemory;

  Memory(
      {this.time,
      this.rawMaxMemory,
      this.maxMemory,
      this.rawUsageMemory,
      this.usageMemory});

  Memory.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    rawMaxMemory = double.parse(json['raw_max_memory'].toString());
    maxMemory = json['max_memory'].toString();
    rawUsageMemory = double.parse(json['raw_usage_memory'].toString());
    usageMemory = json['usage_memory'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['raw_max_memory'] = this.rawMaxMemory;
    data['max_memory'] = this.maxMemory;
    data['raw_usage_memory'] = this.rawUsageMemory;
    data['usage_memory'] = this.usageMemory;
    return data;
  }
}

class Network {
  String? time;
  double? rawNetin;
  String? netin;
  double? rawNetout;
  String? netout;

  Network({this.time, this.rawNetin, this.netin, this.rawNetout, this.netout});

  Network.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    rawNetin = double.parse(json['raw_netin'].toString());
    netin = json['netin'];
    rawNetout = double.parse(json['raw_netout'].toString());
    netout = json['netout'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['raw_netin'] = this.rawNetin;
    data['netin'] = this.netin;
    data['raw_netout'] = this.rawNetout;
    data['netout'] = this.netout;
    return data;
  }
}

class Disk {
  String? time;
  double? rawDiskwrite;
  String? diskwrite;
  double? rawDiskread;
  String? diskread;

  Disk(
      {this.time,
      this.rawDiskwrite,
      this.diskwrite,
      this.rawDiskread,
      this.diskread});

  Disk.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    rawDiskwrite = double.parse(json['raw_diskwrite'].toString());
    diskwrite = json['diskwrite'];
    rawDiskread = double.parse(json['raw_diskread'].toString());
    diskread = json['diskread'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['raw_diskwrite'] = this.rawDiskwrite;
    data['diskwrite'] = this.diskwrite;
    data['raw_diskread'] = this.rawDiskread;
    data['diskread'] = this.diskread;
    return data;
  }
}
