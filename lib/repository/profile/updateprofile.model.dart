class UpdateProfile {
  String? firstName;
  String? lastName;
  int? countryId;
  int? provinceId;
  int? cityId;
  int? districtId;
  String? address;
  String? phone;

  UpdateProfile(
      {this.firstName,
      this.lastName,
      this.countryId,
      this.provinceId,
      this.cityId,
      this.districtId,
      this.address,
      this.phone});

  UpdateProfile.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    countryId = json['country_id'];
    provinceId = json['province_id'];
    cityId = json['city_id'];
    districtId = json['district_id'];
    address = json['address'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['country_id'] = countryId;
    data['province_id'] = provinceId;
    data['city_id'] = cityId;
    data['district_id'] = districtId;
    data['address'] = address;
    data['phone'] = phone;
    return data;
  }
}

class UpdatedProfile {
  String? firstName;
  String? lastName;
  int? countryId;
  String? provinceId;
  String? cityId;
  String? districtId;
  String? address;
  String? phone;

  UpdatedProfile(
      {this.firstName,
      this.lastName,
      this.countryId,
      this.provinceId,
      this.cityId,
      this.districtId,
      this.address,
      this.phone});

  UpdatedProfile.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    countryId = json['country_id'];
    provinceId = json['province_id'];
    cityId = json['city_id'];
    districtId = json['district_id'];
    address = json['address'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['country_id'] = countryId;
    data['province_id'] = provinceId;
    data['city_id'] = cityId;
    data['district_id'] = districtId;
    data['address'] = address;
    data['phone'] = phone;
    return data;
  }
}

class UpdateProfileErrorModel {
  String? message;

  UpdateProfileErrorModel({this.message});

  UpdateProfileErrorModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;

    return data;
  }
}
