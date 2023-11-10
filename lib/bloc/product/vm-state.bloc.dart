import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:maxcloud/repository/auth/login.model.dart';
import 'package:maxcloud/repository/auth/otp.model.dart';
import 'package:maxcloud/repository/auth/register.model.dart';
import 'package:maxcloud/repository/instances/vm-state.model.dart';
import 'package:maxcloud/services/api.services.dart';

abstract class VMStateEvent {}

class StartVMEvent extends VMStateEvent {
  final String token, vmUuid;

  StartVMEvent(this.token, this.vmUuid);
}

class RestartVMEvent extends VMStateEvent {
  final String token, vmUuid;

  RestartVMEvent(this.token, this.vmUuid);
}

class ShutdownVMEvent extends VMStateEvent {
  final String token, vmUuid;

  ShutdownVMEvent(this.token, this.vmUuid);
}

abstract class VMState {}

class InitialVMState extends VMState {}

class LoadingVMState extends VMState {}

class LoadedVMState extends VMState {
  final VMStateModel data;
  LoadedVMState(this.data);
}

class ErrorVMState extends VMState {
  final AuthErrorModel error;
  ErrorVMState(this.error);
}

//===================

class VMStateBloc extends Bloc<VMStateEvent, VMState> {
  VMStateBloc() : super(InitialVMState()) {
    on<VMStateEvent>((event, emit) async {
      if (event is StartVMEvent) {
        emit(LoadingVMState());

        final response =
            await ApiServices.startVMState(event.token, event.vmUuid);

        print(response.runtimeType);

        if (response.runtimeType.toString() == 'Response<dynamic>') {
          print("status code ${response}");
          if (response.statusCode == 200) {
            print(response);
            emit(LoadedVMState(VMStateModel.fromJson(response.data)));
          } else {
            emit(ErrorVMState(response.data));
          }
        } else if (response.runtimeType.toString() == 'DioException') {
          Map<String, dynamic> errorData = response.response?.data;
          emit(ErrorVMState(AuthErrorModel.fromJson(errorData)));
          print(response);
        }
      } else if (event is RestartVMEvent) {
        emit(LoadingVMState());

        final response =
            await ApiServices.restartVMState(event.token, event.vmUuid);

        if (response.runtimeType.toString() == 'Response<dynamic>') {
          print("status code ${response}");
          if (response.statusCode == 200) {
            print(response);
            emit(LoadedVMState(VMStateModel.fromJson(response.data)));
          } else {
            emit(ErrorVMState(response.data));
          }
        } else if (response.runtimeType.toString() == 'DioException') {
          Map<String, dynamic> errorData = response.response?.data;
          emit(ErrorVMState(AuthErrorModel.fromJson(errorData)));
          print(response);
        }
      } else if (event is ShutdownVMEvent) {
        emit(LoadingVMState());

        final response =
            await ApiServices.shutdownVMState(event.token, event.vmUuid);

        if (response.runtimeType.toString() == 'Response<dynamic>') {
          if ((response as Response<dynamic>).statusCode == 200) {
            emit(LoadedVMState(VMStateModel.fromJson(response.data)));
          } else {
            emit(ErrorVMState(response.data));
          }
        } else if (response.runtimeType.toString() == 'DioException') {
          Map<String, dynamic> errorData = response.response?.data;
          emit(ErrorVMState(AuthErrorModel.fromJson(errorData)));
        }
      }
    });
  }
}
