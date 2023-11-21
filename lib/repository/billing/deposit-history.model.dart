class DepositHistoryModel {
  String? message;
  Data? data;

  DepositHistoryModel({this.message, this.data});

  DepositHistoryModel.fromJson(Map<String, dynamic> json) {
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
  List<DepositData>? depositData;
  Page? page;

  Data({this.depositData, this.page});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      depositData = <DepositData>[];
      json['data'].forEach((v) {
        depositData!.add(new DepositData.fromJson(v));
      });
    }
    page = json['page'] != null ? new Page.fromJson(json['page']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.depositData != null) {
      data['deposit_data'] = this.depositData!.map((v) => v.toJson()).toList();
    }
    if (this.page != null) {
      data['page'] = this.page!.toJson();
    }
    return data;
  }
}

class DepositData {
  int? id;
  String? invoiceNumber;
  String? description;
  int? amount;
  String? referenceNumber;
  String? method;
  String? status;
  String? createdAt;
  String? expiredAt;
  double? balanceAfter;
  String? paymentLink;

  DepositData(
      {this.id,
      this.invoiceNumber,
      this.description,
      this.amount,
      this.referenceNumber,
      this.method,
      this.status,
      this.createdAt,
      this.expiredAt,
      this.balanceAfter,
      this.paymentLink});

  DepositData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    invoiceNumber = json['invoice_number'];
    description = json['description'];
    amount = json['amount'];
    referenceNumber = json['reference_number'];
    method = json['method'];
    status = json['status'];
    createdAt = json['created_at'];
    expiredAt = json['expired_at'];
    balanceAfter = json['balance_after'];
    paymentLink = json['payment_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['invoice_number'] = this.invoiceNumber;
    data['description'] = this.description;
    data['amount'] = this.amount;
    data['reference_number'] = this.referenceNumber;
    data['method'] = this.method;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['expired_at'] = this.expiredAt;
    data['balance_after'] = this.balanceAfter;
    data['payment_link'] = this.paymentLink;
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
