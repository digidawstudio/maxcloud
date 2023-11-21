import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:maxcloud/repository/billing/create-invoice.model.dart';
import 'package:maxcloud/repository/billing/month-summary.model.dart';
import 'package:maxcloud/services/api.services.dart';

abstract class CreateInvoiceEvent {}

class PostCreateInvoiceEvent extends CreateInvoiceEvent {
  final String token;
  final dynamic body;

  PostCreateInvoiceEvent(this.token, this.body);
}

class InitialCreateInvoiceEvent extends CreateInvoiceEvent {}

abstract class CreateInvoiceState {}

class InitialCreateInvoiceState extends CreateInvoiceState {}

class LoadingCreateInvoiceState extends CreateInvoiceState {}

class LoadedCreateInvoiceState extends CreateInvoiceState {
  final CreateInvoiceModel data;
  LoadedCreateInvoiceState(this.data);
}

class ErrorCreateInvoiceState extends CreateInvoiceState {
  final String error;
  ErrorCreateInvoiceState(this.error);
}

//===================

class CreateInvoiceBloc extends Bloc<CreateInvoiceEvent, CreateInvoiceState> {
  CreateInvoiceBloc() : super(InitialCreateInvoiceState()) {
    on<CreateInvoiceEvent>((event, emit) async {
      print(event.runtimeType);
      if (event is PostCreateInvoiceEvent) {
        emit(LoadingCreateInvoiceState());

        final response =
            await ApiServices.createInvoice(event.token, event.body);

        print(response.runtimeType);

        if (response.runtimeType.toString() == 'Response<dynamic>') {
          print("status code ${response}");
          if (response.statusCode == 201) {
            print(response);
            emit(LoadedCreateInvoiceState(
                CreateInvoiceModel.fromJson(response.data)));
          }
        } else if (response.runtimeType.toString() == 'DioException') {
          Map<String, dynamic> errorData = response.response?.data;

          emit(ErrorCreateInvoiceState(
              MonthSummaryErrorModel.fromJson(errorData).message ?? ""));
          print(response);
        }
      }
      if (event is InitialCreateInvoiceEvent) {
        emit(InitialCreateInvoiceState());
      }
    });
  }
}
