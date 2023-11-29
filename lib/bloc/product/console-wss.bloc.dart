import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:maxcloud/repository/auth/login.model.dart';
import 'package:maxcloud/repository/auth/otp.model.dart';
import 'package:maxcloud/repository/auth/register.model.dart';
import 'package:maxcloud/repository/instances/console-wss.model.dart';
import 'package:maxcloud/repository/instances/vm-state.model.dart';
import 'package:maxcloud/services/api.services.dart';

abstract class ConsoleWSSEvent {}

class FetchConsoleWSSEvent extends ConsoleWSSEvent {
  final String? token, vmUuid;

  FetchConsoleWSSEvent(this.token, this.vmUuid);
}

abstract class ConsoleWSSState {}

class InitialConsoleWSSState extends ConsoleWSSState {}

class LoadingConsoleWSSState extends ConsoleWSSState {}

class LoadedConsoleWSSState extends ConsoleWSSState {
  final ConsoleWSSModel data;
  LoadedConsoleWSSState(this.data);
}

class ErrorConsoleWSSState extends ConsoleWSSState {
  final AuthErrorModel error;
  ErrorConsoleWSSState(this.error);
}

//===================

class ConsoleWSSBloc extends Bloc<ConsoleWSSEvent, ConsoleWSSState> {
  ConsoleWSSBloc() : super(InitialConsoleWSSState()) {
    on<ConsoleWSSEvent>((event, emit) async {
      if (event is FetchConsoleWSSEvent) {
        emit(LoadingConsoleWSSState());

        final response =
            await ApiServices.getConsolewWSS(event.token!, event.vmUuid!);

        print(response.runtimeType);

        if (response.runtimeType.toString() == 'Response<dynamic>') {
          print("status code ${response}");
          if (response.statusCode == 200) {
            print(response);
            emit(
                LoadedConsoleWSSState(ConsoleWSSModel.fromJson(response.data)));
          } else {
            emit(ErrorConsoleWSSState(response.data));
          }
        } else if (response.runtimeType.toString() == 'DioException') {
          Map<String, dynamic> errorData = response.response?.data;
          emit(ErrorConsoleWSSState(AuthErrorModel.fromJson(errorData)));
          print(response);
        }
      }
    });
  }
}
