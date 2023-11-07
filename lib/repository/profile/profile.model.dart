class ProfileModel {
  String? message;
  Data? data;

  ProfileModel({this.message, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
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
        json['country'] != null ? Country.fromJson(json['country']) : null;
    province = json['province'] != null
        ? Province.fromJson(json['province'])
        : null;
    cProvince = json['c_province'];
    city = json['city'] != null ? City.fromJson(json['city']) : null;
    cCity = json['c_city'];
    district = json['district'] != null
        ? District.fromJson(json['district'])
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['current_balance'] = currentBalance;
    data['actual_balance'] = actualBalance;
    if (country != null) {
      data['country'] = country!.toJson();
    }
    if (province != null) {
      data['province'] = province!.toJson();
    }
    data['c_province'] = cProvince;
    if (city != null) {
      data['city'] = city!.toJson();
    }
    data['c_city'] = cCity;
    if (district != null) {
      data['district'] = district!.toJson();
    }
    data['address'] = address;
    data['is_active'] = isActive;
    data['is_registration_completed'] = isRegistrationCompleted;
    data['is_suspended'] = isSuspended;
    data['is_phone_verified'] = isPhoneVerified;
    data['vm_limit'] = vmLimit;
    data['phone'] = phone;
    data['price_percentage'] = pricePercentage;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    data['phonecode'] = phonecode;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

class City {
  int? id;
  String? name;
  int? provinceId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['province_id'] = provinceId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

class District {
  int? id;
  String? name;
  int? cityId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['city_id'] = cityId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;

    return data;
  }
}
