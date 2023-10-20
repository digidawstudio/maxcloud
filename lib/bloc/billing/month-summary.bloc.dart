import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:maxcloud/repository/billing/month-summary.model.dart';
import 'package:maxcloud/services/api.services.dart';

abstract class MonthSummaryEvent {}

class FetchCurrentMonthSummaryEvent extends MonthSummaryEvent {
  final String token;

  FetchCurrentMonthSummaryEvent(this.token);
}

abstract class MonthSummaryState {}

class InitialMonthSummaryState extends MonthSummaryState {}

class LoadingMonthSummaryState extends MonthSummaryState {}

class LoadedMonthSummaryState extends MonthSummaryState {
  final MonthSummaryModel data;
  LoadedMonthSummaryState(this.data);
}

class ErrorMonthSummaryState extends MonthSummaryState {
  final MonthSummaryErrorModel error;
  ErrorMonthSummaryState(this.error);
}

//===================

class MonthSummaryBloc extends Bloc<MonthSummaryEvent, MonthSummaryState> {
  MonthSummaryBloc() : super(InitialMonthSummaryState()) {
    on<MonthSummaryEvent>((event, emit) async {
      print(event.runtimeType);
      if (event is FetchCurrentMonthSummaryEvent) {
        emit(LoadingMonthSummaryState());

        final response = await ApiServices.getCurrentMonthSummary(event.token);

        print(response.runtimeType);

        if (response.runtimeType.toString() == 'Response<dynamic>') {
          print("status code ${response}");
          if (response.statusCode == 200) {
            print(response);
            emit(LoadedMonthSummaryState(
                MonthSummaryModel.fromJson(response.data)));
          } else {
            emit(ErrorMonthSummaryState(response.data));
          }
        } else if (response.runtimeType.toString() == 'DioException') {
          Map<String, dynamic> errorData = response.response?.data;
          emit(ErrorMonthSummaryState(
              MonthSummaryErrorModel.fromJson(errorData)));
          print(response);
        }
      }
    });
  }
}
