class MonthSummaryModel {
  String? message;
  Data? data;

  MonthSummaryModel({this.message, this.data});

  MonthSummaryModel.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_balance'] = currentBalance;
    data['current_cost'] = currentCost;
    data['actual_balance'] = actualBalance;
    data['estimated_monthly_total'] = estimatedMonthlyTotal;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;

    return data;
  }
}
