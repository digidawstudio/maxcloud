import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:maxcloud/repository/billing/deposit-history.model.dart';
import 'package:maxcloud/repository/billing/month-summary.model.dart';
import 'package:maxcloud/services/api.services.dart';

abstract class DepositHistoryEvent {}

class FetchDepositHistoryEvent extends DepositHistoryEvent {
  final String token;
  final int page, limit;

  FetchDepositHistoryEvent(this.token, this.page, this.limit);
}

abstract class DepositHistoryState {}

class InitialDepositHistoryState extends DepositHistoryState {}

class LoadingDepositHistoryState extends DepositHistoryState {}

class LoadedDepositHistoryState extends DepositHistoryState {
  final DepositHistoryModel data;
  LoadedDepositHistoryState(this.data);
}

class ErrorDepositHistoryState extends DepositHistoryState {
  final MonthSummaryErrorModel error;
  ErrorDepositHistoryState(this.error);
}

//===================

class DepositHistoryBloc
    extends Bloc<DepositHistoryEvent, DepositHistoryState> {
  DepositHistoryBloc() : super(InitialDepositHistoryState()) {
    on<DepositHistoryEvent>((event, emit) async {
      print(event.runtimeType);
      if (event is FetchDepositHistoryEvent) {
        emit(LoadingDepositHistoryState());

        final response = await ApiServices.getDepositHistory(
            event.token, event.page, event.limit);

        print(response.runtimeType);

        if (response.runtimeType.toString() == 'Response<dynamic>') {
          print("status code ${response}");
          if (response.statusCode == 200) {
            print(response);
            emit(LoadedDepositHistoryState(
                DepositHistoryModel.fromJson(response.data)));
          } else {
            emit(ErrorDepositHistoryState(response.data));
          }
        } else if (response.runtimeType.toString() == 'DioException') {
          Map<String, dynamic> errorData = response.response?.data;
          emit(ErrorDepositHistoryState(
              MonthSummaryErrorModel.fromJson(errorData)));
          print(response);
        }
      }
    });
  }
}
