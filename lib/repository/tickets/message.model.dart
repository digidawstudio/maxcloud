class MessageModel {
  String? message;
  Data? data;

  MessageModel({this.message, this.data});

  MessageModel.fromJson(Map<String, dynamic> json) {
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
  String? content;
  int? creatorId;
  String? creatorType;
  bool? isAdmin;
  int? ticketId;
  String? updatedAt;
  String? createdAt;
  int? id;
  Creator? creator;
  List<String>? attachments;

  Data(
      {this.content,
      this.creatorId,
      this.creatorType,
      this.isAdmin,
      this.ticketId,
      this.updatedAt,
      this.createdAt,
      this.id,
      this.creator,
      this.attachments});

  Data.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    creatorId = json['creator_id'];
    creatorType = json['creator_type'];
    isAdmin = json['is_admin'];
    ticketId = json['ticket_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    creator =
        json['creator'] != null ? new Creator.fromJson(json['creator']) : null;
    attachments = json['attachments'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['creator_id'] = this.creatorId;
    data['creator_type'] = this.creatorType;
    data['is_admin'] = this.isAdmin;
    data['ticket_id'] = this.ticketId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    if (this.creator != null) {
      data['creator'] = this.creator!.toJson();
    }
    data['attachments'] = this.attachments;
    return data;
  }
}

class Creator {
  int? id;
  String? firstname;
  String? lastname;
  String? email;
  String? address;
  String? emailVerifiedAt;
  String? lastLoginAt;
  String? lastLoginIp;
  String? lastLoginUserAgent;
  int? loginAttempt;
  int? isActive;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? isRegistrationCompleted;
  String? suspendedAt;
  int? vmLimit;
  String? phone;
  double? currentBalance;
  int? provinceId;
  int? cityId;
  int? districtId;
  String? socialType;
  int? countryId;
  String? provinceCustom;
  String? cityCustom;
  String? minusAt;
  int? lowBalanceNotice;
  double? actualBalance;
  String? phoneVerifiedAt;
  String? lockedAt;
  int? pricePercentage;
  String? referralCode;

  Creator(
      {this.id,
      this.firstname,
      this.lastname,
      this.email,
      this.address,
      this.emailVerifiedAt,
      this.lastLoginAt,
      this.lastLoginIp,
      this.lastLoginUserAgent,
      this.loginAttempt,
      this.isActive,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.isRegistrationCompleted,
      this.suspendedAt,
      this.vmLimit,
      this.phone,
      this.currentBalance,
      this.provinceId,
      this.cityId,
      this.districtId,
      this.socialType,
      this.countryId,
      this.provinceCustom,
      this.cityCustom,
      this.minusAt,
      this.lowBalanceNotice,
      this.actualBalance,
      this.phoneVerifiedAt,
      this.lockedAt,
      this.pricePercentage,
      this.referralCode});

  Creator.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    address = json['address'];
    emailVerifiedAt = json['email_verified_at'];
    lastLoginAt = json['last_login_at'];
    lastLoginIp = json['last_login_ip'];
    lastLoginUserAgent = json['last_login_user_agent'];
    loginAttempt = json['login_attempt'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    isRegistrationCompleted = json['is_registration_completed'];
    suspendedAt = json['suspended_at'];
    vmLimit = json['vm_limit'];
    phone = json['phone'];
    currentBalance = json['current_balance'];
    provinceId = json['province_id'];
    cityId = json['city_id'];
    districtId = json['district_id'];
    socialType = json['social_type'];
    countryId = json['country_id'];
    provinceCustom = json['province_custom'];
    cityCustom = json['city_custom'];
    minusAt = json['minus_at'];
    lowBalanceNotice = json['low_balance_notice'];
    actualBalance = json['actual_balance'];
    phoneVerifiedAt = json['phone_verified_at'];
    lockedAt = json['locked_at'];
    pricePercentage = json['price_percentage'];
    referralCode = json['referral_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    data['address'] = this.address;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['last_login_at'] = this.lastLoginAt;
    data['last_login_ip'] = this.lastLoginIp;
    data['last_login_user_agent'] = this.lastLoginUserAgent;
    data['login_attempt'] = this.loginAttempt;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['is_registration_completed'] = this.isRegistrationCompleted;
    data['suspended_at'] = this.suspendedAt;
    data['vm_limit'] = this.vmLimit;
    data['phone'] = this.phone;
    data['current_balance'] = this.currentBalance;
    data['province_id'] = this.provinceId;
    data['city_id'] = this.cityId;
    data['district_id'] = this.districtId;
    data['social_type'] = this.socialType;
    data['country_id'] = this.countryId;
    data['province_custom'] = this.provinceCustom;
    data['city_custom'] = this.cityCustom;
    data['minus_at'] = this.minusAt;
    data['low_balance_notice'] = this.lowBalanceNotice;
    data['actual_balance'] = this.actualBalance;
    data['phone_verified_at'] = this.phoneVerifiedAt;
    data['locked_at'] = this.lockedAt;
    data['price_percentage'] = this.pricePercentage;
    data['referral_code'] = this.referralCode;
    return data;
  }
}
