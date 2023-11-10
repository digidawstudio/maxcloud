import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:maxcloud/repository/billing/create-invoice.model.dart';
import 'package:maxcloud/repository/billing/month-summary.model.dart';
import 'package:maxcloud/services/api.services.dart';

abstract class ChangePasswordEvent {}

class PostChangePasswordEvent extends ChangePasswordEvent {
  final String token;
  final dynamic body;

  PostChangePasswordEvent(this.token, this.body);
}

abstract class ChangePasswordState {}

class InitialChangePasswordState extends ChangePasswordState {}

class LoadingChangePasswordState extends ChangePasswordState {}

class LoadedChangePasswordState extends ChangePasswordState {
  final CreateInvoiceModel data;
  LoadedChangePasswordState(this.data);
}

class ErrorChangePasswordState extends ChangePasswordState {
  final MonthSummaryErrorModel error;
  ErrorChangePasswordState(this.error);
}

//===================

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc() : super(InitialChangePasswordState()) {
    on<ChangePasswordEvent>((event, emit) async {
      print(event.runtimeType);
      if (event is PostChangePasswordEvent) {
        emit(LoadingChangePasswordState());

        final response =
            await ApiServices.changePassword(event.token, event.body);

        print(response.runtimeType);

        if (response.runtimeType.toString() == 'Response<dynamic>') {
          print("status code ${response}");
          if (response.statusCode == 201) {
            print(response);
            emit(LoadedChangePasswordState(
                CreateInvoiceModel.fromJson(response.data)));
          }
        } else if (response.runtimeType.toString() == 'DioException') {
          Map<String, dynamic> errorData = response.response?.data;
          emit(ErrorChangePasswordState(
              MonthSummaryErrorModel.fromJson(errorData)));
          print(response);
        }
      }
    });
  }
}
