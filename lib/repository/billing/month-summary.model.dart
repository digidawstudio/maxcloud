class MonthSummaryModel {
  String? message;
  Data? data;

  MonthSummaryModel({this.message, this.data});

  MonthSummaryModel.fromJson(Map<String, dynamic> json) {
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
  double? currentBalance;
  double? currentCost;
  double? actualBalance;
  double? estimatedMonthlyTotal;

  Data(
      {this.currentBalance,
      this.currentCost,
      this.actualBalance,
      this.estimatedMonthlyTotal});

  Data.fromJson(Map<String, dynamic> json) {
    currentBalance = json['current_balance'];
    currentCost = json['current_cost'];
    actualBalance = json['actual_balance'];
    estimatedMonthlyTotal = json['estimated_monthly_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_balance'] = this.currentBalance;
    data['current_cost'] = this.currentCost;
    data['actual_balance'] = this.actualBalance;
    data['estimated_monthly_total'] = this.estimatedMonthlyTotal;
    return data;
  }
}

class MonthSummaryErrorModel {
  String? message;

  MonthSummaryErrorModel({this.message});

  MonthSummaryErrorModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;

    return data;
  }
}
