class ProfileModel {
  String? message;
  Data? data;

  ProfileModel({this.message, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? fullName;
  String? firstName;
  String? lastName;
  String? email;
  double? currentBalance;
  double? actualBalance;
  Country? country;
  Province? province;
  String? cProvince;
  City? city;
  String? cCity;
  District? district;
  String? address;
  int? isActive;
  bool? isRegistrationCompleted;
  bool? isSuspended;
  bool? isPhoneVerified;
  int? vmLimit;
  String? phone;
  int? pricePercentage;

  Data(
      {this.id,
      this.fullName,
      this.firstName,
      this.lastName,
      this.email,
      this.currentBalance,
      this.actualBalance,
      this.country,
      this.province,
      this.cProvince,
      this.city,
      this.cCity,
      this.district,
      this.address,
      this.isActive,
      this.isRegistrationCompleted,
      this.isSuspended,
      this.isPhoneVerified,
      this.vmLimit,
      this.phone,
      this.pricePercentage});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    currentBalance = json['current_balance'];
    actualBalance = json['actual_balance'];
    country =
        json['country'] != null ? new Country.fromJson(json['country']) : null;
    province = json['province'] != null
        ? new Province.fromJson(json['province'])
        : null;
    cProvince = json['c_province'];
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    cCity = json['c_city'];
    district = json['district'] != null
        ? new District.fromJson(json['district'])
        : null;
    address = json['address'];
    isActive = json['is_active'];
    isRegistrationCompleted = json['is_registration_completed'];
    isSuspended = json['is_suspended'];
    isPhoneVerified = json['is_phone_verified'];
    vmLimit = json['vm_limit'];
    phone = json['phone'];
    pricePercentage = json['price_percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['current_balance'] = this.currentBalance;
    data['actual_balance'] = this.actualBalance;
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    if (this.province != null) {
      data['province'] = this.province!.toJson();
    }
    data['c_province'] = this.cProvince;
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    data['c_city'] = this.cCity;
    if (this.district != null) {
      data['district'] = this.district!.toJson();
    }
    data['address'] = this.address;
    data['is_active'] = this.isActive;
    data['is_registration_completed'] = this.isRegistrationCompleted;
    data['is_suspended'] = this.isSuspended;
    data['is_phone_verified'] = this.isPhoneVerified;
    data['vm_limit'] = this.vmLimit;
    data['phone'] = this.phone;
    data['price_percentage'] = this.pricePercentage;
    return data;
  }
}

class Country {
  int? id;
  String? code;
  String? name;
  int? phonecode;

  Country({this.id, this.code, this.name, this.phonecode});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    phonecode = json['phonecode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['phonecode'] = this.phonecode;
    return data;
  }
}

class Province {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Province(
      {this.id, this.name, this.createdAt, this.updatedAt, this.deletedAt});

  Province.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class City {
  int? id;
  String? name;
  int? provinceId;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  City(
      {this.id,
      this.name,
      this.provinceId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    provinceId = json['province_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['province_id'] = this.provinceId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class District {
  int? id;
  String? name;
  int? cityId;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  District(
      {this.id,
      this.name,
      this.cityId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  District.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    cityId = json['city_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['city_id'] = this.cityId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class ProfileErrorModel {
  String? message;

  ProfileErrorModel({this.message});

  ProfileErrorModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;

    return data;
  }
}
