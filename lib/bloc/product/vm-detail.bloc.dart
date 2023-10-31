import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:maxcloud/repository/instances/my-latest-vm.model.dart';
import 'package:maxcloud/repository/instances/my-virtual-machines.model.dart';
import 'package:maxcloud/repository/instances/vm-detail.model.dart';
import 'package:maxcloud/services/api.services.dart';

import '../../repository/auth/login.model.dart';

abstract class VMDetailEvent {}

class FetchVMDetailEvent extends VMDetailEvent {
  final String? token;
  final String? vmUuid;

  FetchVMDetailEvent(this.token, this.vmUuid);
}

abstract class VMDetailState {}

class InitialVMDetailState extends VMDetailState {}

class LoadingVMDetailState extends VMDetailState {}

class LoadedVMDetailState extends VMDetailState {
  final VMDetailModel vmDetail;
  LoadedVMDetailState(this.vmDetail);
}

class ErrorVMDetailState extends VMDetailState {
  final String error;
  ErrorVMDetailState(this.error);
}

//===================

class VMDetailBloc extends Bloc<VMDetailEvent, VMDetailState> {
  VMDetailBloc() : super(InitialVMDetailState()) {
    on<VMDetailEvent>((event, emit) async {
      if (event is FetchVMDetailEvent) {
        emit(LoadingVMDetailState());

        final response =
            await ApiServices.getVMDetail(event.token!, event.vmUuid!);

        print(response.runtimeType);

        if (response.runtimeType.toString() == 'Response<dynamic>') {
          print("status code ${response}");
          if (response.statusCode == 200) {
            print(response);
            emit(LoadedVMDetailState(VMDetailModel.fromJson(response.data)));
          } else {
            emit(ErrorVMDetailState(response.data));
          }
        } else if (response.runtimeType.toString() == 'DioException') {
          Map<String, dynamic> errorData = response.response?.data;
          emit(ErrorVMDetailState(
              AuthErrorModel.fromJson(errorData).message ?? ""));
          print(response);
        }
      }
    });
  }
}
