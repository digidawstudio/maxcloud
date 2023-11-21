class PaymentMethodModel {
  String? message;
  Data? data;

  PaymentMethodModel({this.message, this.data});

  PaymentMethodModel.fromJson(Map<String, dynamic> json) {
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
  List<Bank>? bank;
  List<Card>? card;
  List<Ritel>? ritel;
  List<Ewallet>? ewallet;
  List<Qris>? qris;

  Data({this.bank, this.card, this.ritel, this.ewallet, this.qris});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['bank'] != null) {
      bank = <Bank>[];
      json['bank'].forEach((v) {
        bank!.add(Bank.fromJson(v));
      });
    }
    if (json['card'] != null) {
      card = <Card>[];
      json['card'].forEach((v) {
        card!.add(Card.fromJson(v));
      });
    }
    if (json['ritel'] != null) {
      ritel = <Ritel>[];
      json['ritel'].forEach((v) {
        ritel!.add(Ritel.fromJson(v));
      });
    }
    if (json['ewallet'] != null) {
      ewallet = <Ewallet>[];
      json['ewallet'].forEach((v) {
        ewallet!.add(Ewallet.fromJson(v));
      });
    }
    if (json['qris'] != null) {
      qris = <Qris>[];
      json['qris'].forEach((v) {
        qris!.add(Qris.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (bank != null) {
      data['bank'] = bank!.map((v) => v.toJson()).toList();
    }
    if (card != null) {
      data['card'] = card!.map((v) => v.toJson()).toList();
    }
    if (ritel != null) {
      data['ritel'] = ritel!.map((v) => v.toJson()).toList();
    }
    if (ewallet != null) {
      data['ewallet'] = ewallet!.map((v) => v.toJson()).toList();
    }
    if (qris != null) {
      data['qris'] = qris!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Bank {
  String? name;
  String? code;
  String? image;
  int? fee;
  int? vat;

  Bank({this.name, this.code, this.image, this.fee, this.vat});

  Bank.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    image = json['image'];
    fee = json['fee'];
    vat = json['vat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['code'] = code;
    data['image'] = image;
    data['fee'] = fee;
    data['vat'] = vat;
    return data;
  }
}

class Card {
  String? name;
  String? code;
  String? image;
  int? fee;
  int? vat;

  Card({this.name, this.code, this.image, this.fee, this.vat});

  Card.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    image = json['image'];
    fee = json['fee'];
    vat = json['vat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['code'] = code;
    data['image'] = image;
    data['fee'] = fee;
    data['vat'] = vat;
    return data;
  }
}

class Ritel {
  String? name;
  String? code;
  String? image;
  int? fee;
  int? vat;

  Ritel({this.name, this.code, this.image, this.fee, this.vat});

  Ritel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    image = json['image'];
    fee = json['fee'];
    vat = json['vat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['code'] = code;
    data['image'] = image;
    data['fee'] = fee;
    data['vat'] = vat;
    return data;
  }
}

class Ewallet {
  String? name;
  String? code;
  String? image;
  int? fee;
  int? vat;

  Ewallet({this.name, this.code, this.image, this.fee, this.vat});

  Ewallet.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    image = json['image'];
    fee = json['fee'];
    vat = json['vat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['code'] = code;
    data['image'] = image;
    data['fee'] = fee;
    data['vat'] = vat;
    return data;
  }
}

class Qris {
  String? name;
  String? code;
  String? image;
  int? fee;
  int? vat;

  Qris({this.name, this.code, this.image, this.fee, this.vat});

  Qris.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    image = json['image'];
    fee = json['fee'];
    vat = json['vat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['code'] = code;
    data['image'] = image;
    data['fee'] = fee;
    data['vat'] = vat;
    return data;
  }
}
