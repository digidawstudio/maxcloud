class TicketsModel {
  String? message;
  Data? data;

  TicketsModel({this.message, this.data});

  TicketsModel.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data.map((v) => v.toJson()).toList();
      if (page != null) {
      data['page'] = page!.toJson();
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
        members!.add(Members.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    createdAtHrm = json['created_at_hrm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['subject'] = subject;
    data['content'] = content;
    data['service'] = service;
    data['status'] = status;
    data['priority'] = priority;
    data['department'] = department;
    data['conversation_count'] = conversationCount;
    if (members != null) {
      data['members'] = members!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = createdAt;
    data['created_at_hrm'] = createdAtHrm;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['is_admin'] = isAdmin;
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
