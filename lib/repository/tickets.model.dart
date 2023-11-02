class TicketsModel {
  String? message;
  Data? data;

  TicketsModel({this.message, this.data});

  TicketsModel.fromJson(Map<String, dynamic> json) {
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
  late List<TicketData> data;
  Page? page;

  Data({this.data = const [], this.page});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <TicketData>[];
      json['data'].forEach((v) {
        data.add(TicketData.fromJson(v));
      });
    }
    page = json['page'] != null ? Page.fromJson(json['page']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    if (this.page != null) {
      data['page'] = this.page!.toJson();
    }
    return data;
  }
}

class TicketData {
  String? token;
  String? subject;
  String? content;
  String? service;
  String? status;
  String? priority;
  String? department;
  int? conversationCount;
  List<Members>? members;
  String? createdAt;
  String? createdAtHrm;

  TicketData(
      {this.token,
      this.subject,
      this.content,
      this.service,
      this.status,
      this.priority,
      this.department,
      this.conversationCount,
      this.members,
      this.createdAt,
      this.createdAtHrm});

  TicketData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    subject = json['subject'];
    content = json['content'];
    service = json['service'];
    status = json['status'];
    priority = json['priority'];
    department = json['department'];
    conversationCount = json['conversation_count'];
    if (json['members'] != null) {
      members = <Members>[];
      json['members'].forEach((v) {
        members!.add(new Members.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    createdAtHrm = json['created_at_hrm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['subject'] = this.subject;
    data['content'] = this.content;
    data['service'] = this.service;
    data['status'] = this.status;
    data['priority'] = this.priority;
    data['department'] = this.department;
    data['conversation_count'] = this.conversationCount;
    if (this.members != null) {
      data['members'] = this.members!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['created_at_hrm'] = this.createdAtHrm;
    return data;
  }
}

class Members {
  int? id;
  String? name;
  bool? isAdmin;

  Members({this.id, this.name, this.isAdmin});

  Members.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isAdmin = json['is_admin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['is_admin'] = this.isAdmin;
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
