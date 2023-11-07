class NotificationModel {
  String? message;
  Data? data;

  NotificationModel({this.message, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
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
  List<NotifData>? notifData;
  Page? page;

  Data({this.notifData, this.page});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      notifData = <NotifData>[];
      json['data'].forEach((v) {
        notifData!.add(NotifData.fromJson(v));
      });
    }
    page = json['page'] != null ? Page.fromJson(json['page']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (notifData != null) {
      data['data'] = notifData!.map((v) => v.toJson()).toList();
    }
    if (page != null) {
      data['page'] = page!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['title'] = title;
    data['content'] = content;
    data['redirect'] = redirect;
    data['created_at'] = createdAt;
    data['created_at_hrf'] = createdAtHrf;
    data['read_at'] = readAt;
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
