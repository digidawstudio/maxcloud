class ConversationModel {
  String? message;
  Data? data;

  ConversationModel({this.message, this.data});

  ConversationModel.fromJson(Map<String, dynamic> json) {
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
  List<ConversationData>? data;
  Page? page;

  Data({this.data, this.page});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ConversationData>[];
      json['data'].forEach((v) {
        data!.add(ConversationData.fromJson(v));
      });
    }
    page = json['page'] != null ? Page.fromJson(json['page']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (page != null) {
      data['page'] = page!.toJson();
    }
    return data;
  }
}

class ConversationData {
  int? id;
  String? content;
  int? isAdmin;
  int? creatorId;
  String? creatorName;
  String? creatorEmail;
  String? dateAt;
  String? timeAt;
  List<Attachments>? attachments;

  ConversationData(
      {this.id,
      this.content,
      this.isAdmin,
      this.creatorId,
      this.creatorName,
      this.creatorEmail,
      this.dateAt,
      this.timeAt,
      this.attachments});

  ConversationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    isAdmin = json['is_admin'] == true ? 1 : json['is_admin'] == false ? 0 : json['is_admin'];
    creatorId = json['creator_id'];
    creatorName = json['creator_name'];
    creatorEmail = json['creator_email'];
    dateAt = json['date_at'];
    timeAt = json['time_at'];
    if (json['attachments'] != null) {
      attachments = <Attachments>[];
      json['attachments'].forEach((v) {
        attachments!.add(Attachments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['content'] = content;
    data['is_admin'] = isAdmin;
    data['creator_id'] = creatorId;
    data['creator_name'] = creatorName;
    data['creator_email'] = creatorEmail;
    data['date_at'] = dateAt;
    data['time_at'] = timeAt;
    if (attachments != null) {
      data['attachments'] = attachments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attachments {
  int? id;
  String? filename;
  String? extension;
  String? path;
  String? size;

  Attachments({this.id, this.filename, this.extension, this.path, this.size});

  Attachments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    filename = json['filename'];
    extension = json['extension'];
    path = json['path'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['filename'] = filename;
    data['extension'] = extension;
    data['path'] = path;
    data['size'] = size;
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
