import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:maxcloud/repository/billing/deposit-detail.model.dart';
import 'package:maxcloud/repository/billing/deposit-history.model.dart';
import 'package:maxcloud/repository/billing/month-summary.model.dart';
import 'package:maxcloud/services/api.services.dart';

abstract class DepositDetailEvent {}

class FetchDepositDetailEvent extends DepositDetailEvent {
  final String token, invoiceId;

  FetchDepositDetailEvent(this.token, this.invoiceId);
}

abstract class DepositDetailState {}

class InitialDepositDetailState extends DepositDetailState {}

class LoadingDepositDetailState extends DepositDetailState {}

class LoadedDepositDetailState extends DepositDetailState {
  final DepositDetailModel data;
  LoadedDepositDetailState(this.data);
}

class ErrorDepositDetailState extends DepositDetailState {
  final MonthSummaryErrorModel error;
  ErrorDepositDetailState(this.error);
}

//===================

class DepositDetailBloc extends Bloc<DepositDetailEvent, DepositDetailState> {
  DepositDetailBloc() : super(InitialDepositDetailState()) {
    on<DepositDetailEvent>((event, emit) async {
      print(event.runtimeType);
      if (event is FetchDepositDetailEvent) {
        emit(LoadingDepositDetailState());

        final response =
            await ApiServices.getDepositDetail(event.token, event.invoiceId);

        print(response.runtimeType);

        if (response.runtimeType.toString() == 'Response<dynamic>') {
          print("status code ${response}");
          if (response.statusCode == 200) {
            print(response);
            emit(LoadedDepositDetailState(
                DepositDetailModel.fromJson(response.data)));
          } else {
            emit(ErrorDepositDetailState(response.data));
          }
        } else if (response.runtimeType.toString() == 'DioException') {
          Map<String, dynamic> errorData = response.response?.data;
          emit(ErrorDepositDetailState(
              MonthSummaryErrorModel.fromJson(errorData)));
          print(response);
        }
      }
    });
  }
}
