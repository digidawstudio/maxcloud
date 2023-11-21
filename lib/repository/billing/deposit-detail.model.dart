class DepositDetailModel {
  String? message;
  Data? data;

  DepositDetailModel({this.message, this.data});

  DepositDetailModel.fromJson(Map<String, dynamic> json) {
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
  int? amount;
  int? fee;
  String? vaNumber;
  String? qrString;
  String? paymentUrl;
  String? status;
  String? expiredAt;
  int? expiredSeconds;

  Data(
      {this.amount,
      this.fee,
      this.vaNumber,
      this.qrString,
      this.paymentUrl,
      this.status,
      this.expiredAt,
      this.expiredSeconds});

  Data.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    fee = json['fee'];
    vaNumber = json['va_number'];
    qrString = json['qr_string'];
    paymentUrl = json['payment_url'];
    status = json['status'];
    expiredAt = json['expired_at'];
    expiredSeconds = json['expired_seconds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['fee'] = this.fee;
    data['va_number'] = this.vaNumber;
    data['qr_string'] = this.qrString;
    data['payment_url'] = this.paymentUrl;
    data['status'] = this.status;
    data['expired_at'] = this.expiredAt;
    data['expired_seconds'] = this.expiredSeconds;
    return data;
  }
}
