class RRDModel {
  String? message;
  Data? data;

  RRDModel({this.message, this.data});

  RRDModel.fromJson(Map<String, dynamic> json) {
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
  List<Cpu>? cpu;
  List<Memory>? memory;
  List<Network>? network;
  List<Disk>? disk;

  Data({this.cpu, this.memory, this.network, this.disk});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['cpu'] != null) {
      cpu = <Cpu>[];
      json['cpu'].forEach((v) {
        cpu!.add(Cpu.fromJson(v));
      });
    }
    if (json['memory'] != null) {
      memory = <Memory>[];
      json['memory'].forEach((v) {
        memory!.add(Memory.fromJson(v));
      });
    }
    if (json['network'] != null) {
      network = <Network>[];
      json['network'].forEach((v) {
        network!.add(Network.fromJson(v));
      });
    }
    if (json['disk'] != null) {
      disk = <Disk>[];
      json['disk'].forEach((v) {
        disk!.add(Disk.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cpu != null) {
      data['cpu'] = cpu!.map((v) => v.toJson()).toList();
    }
    if (memory != null) {
      data['memory'] = memory!.map((v) => v.toJson()).toList();
    }
    if (network != null) {
      data['network'] = network!.map((v) => v.toJson()).toList();
    }
    if (disk != null) {
      data['disk'] = disk!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time'] = time;
    data['cpu'] = cpu;
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
    rawMaxMemory = json['raw_max_memory'];
    maxMemory = json['max_memory'];
    rawUsageMemory = json['raw_usage_memory'];
    usageMemory = json['usage_memory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time'] = time;
    data['raw_max_memory'] = rawMaxMemory;
    data['max_memory'] = maxMemory;
    data['raw_usage_memory'] = rawUsageMemory;
    data['usage_memory'] = usageMemory;
    return data;
  }
}

class Network {
  String? time;
  int? rawNetin;
  String? netin;
  int? rawNetout;
  String? netout;

  Network({this.time, this.rawNetin, this.netin, this.rawNetout, this.netout});

  Network.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    rawNetin = json['raw_netin'];
    netin = json['netin'];
    rawNetout = json['raw_netout'];
    netout = json['netout'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time'] = time;
    data['raw_netin'] = rawNetin;
    data['netin'] = netin;
    data['raw_netout'] = rawNetout;
    data['netout'] = netout;
    return data;
  }
}

class Disk {
  String? time;
  double? rawDiskwrite;
  String? diskwrite;
  int? rawDiskread;
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
    rawDiskread = json['raw_diskread'];
    diskread = json['diskread'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time'] = time;
    data['raw_diskwrite'] = rawDiskwrite;
    data['diskwrite'] = diskwrite;
    data['raw_diskread'] = rawDiskread;
    data['diskread'] = diskread;
    return data;
  }
}
