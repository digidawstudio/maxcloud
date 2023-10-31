class UpdateProfile {
  String? firstName;
  String? lastName;
  int? countryId;
  String? provinceId;
  String? cityId;
  String? districtId;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['country_id'] = this.countryId;
    data['province_id'] = this.provinceId;
    data['city_id'] = this.cityId;
    data['district_id'] = this.districtId;
    data['address'] = this.address;
    data['phone'] = this.phone;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['country_id'] = this.countryId;
    data['province_id'] = this.provinceId;
    data['city_id'] = this.cityId;
    data['district_id'] = this.districtId;
    data['address'] = this.address;
    data['phone'] = this.phone;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;

    return data;
  }
}

