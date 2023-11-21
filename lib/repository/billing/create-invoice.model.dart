class CreateInvoiceModel {
  String? message;
  Data? data;

  CreateInvoiceModel({this.message, this.data});

  CreateInvoiceModel.fromJson(Map<String, dynamic> json) {
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
  String? merchantCode;
  String? referenceNumber;
  String? paymentUrl;
  int? amount;
  Details? details;
  String? vaNumber;
  String? qrString;
  String? invoiceId;

  Data(
      {this.merchantCode,
      this.referenceNumber,
      this.paymentUrl,
      this.amount,
      this.details,
      this.vaNumber,
      this.qrString,
      this.invoiceId});

  Data.fromJson(Map<String, dynamic> json) {
    merchantCode = json['merchant_code'];
    referenceNumber = json['reference_number'];
    paymentUrl = json['payment_url'];
    amount = json['amount'];
    details =
        json['details'] != null ? new Details.fromJson(json['details']) : null;
    vaNumber = json['va_number'];
    qrString = json['qr_string'];
    invoiceId = json['invoice_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['merchant_code'] = this.merchantCode;
    data['reference_number'] = this.referenceNumber;
    data['payment_url'] = this.paymentUrl;
    data['amount'] = this.amount;
    if (this.details != null) {
      data['details'] = this.details!.toJson();
    }
    data['va_number'] = this.vaNumber;
    data['qr_string'] = this.qrString;
    data['invoice_id'] = this.invoiceId;
    return data;
  }
}

class Details {
  int? amount;
  int? paymentFee;
  int? vat;

  Details({this.amount, this.paymentFee, this.vat});

  Details.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    paymentFee = json['payment_fee'];
    vat = json['vat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['payment_fee'] = this.paymentFee;
    data['vat'] = this.vat;
    return data;
  }
}
