class NotificationModel {
  String? message;
  Data? data;

  NotificationModel({this.message, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
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
  List<NotifData>? notifData;
  Page? page;

  Data({this.notifData, this.page});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      notifData = <NotifData>[];
      json['data'].forEach((v) {
        notifData!.add(new NotifData.fromJson(v));
      });
    }
    page = json['page'] != null ? new Page.fromJson(json['page']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notifData != null) {
      data['data'] = this.notifData!.map((v) => v.toJson()).toList();
    }
    if (this.page != null) {
      data['page'] = this.page!.toJson();
    }
    return data;
  }
}

class NotifData {
  String? id;
  String? type;
  String? title;
  String? content;
  String? redirect;
  String? createdAt;
  String? createdAtHrf;
  String? readAt;

  NotifData(
      {this.id,
      this.type,
      this.title,
      this.content,
      this.redirect,
      this.createdAt,
      this.createdAtHrf,
      this.readAt});

  NotifData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    title = json['title'];
    content = json['content'];
    redirect = json['redirect'];
    createdAt = json['created_at'];
    createdAtHrf = json['created_at_hrf'];
    readAt = json['read_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['title'] = this.title;
    data['content'] = this.content;
    data['redirect'] = this.redirect;
    data['created_at'] = this.createdAt;
    data['created_at_hrf'] = this.createdAtHrf;
    data['read_at'] = this.readAt;
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
