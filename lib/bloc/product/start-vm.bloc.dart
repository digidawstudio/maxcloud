import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:maxcloud/repository/instances/vm-state.model.dart';
import 'package:maxcloud/services/api.services.dart';

import '../../repository/auth/login.model.dart';

abstract class StartVMEvent {}

class StartVMStateEvent extends StartVMEvent {
  final String? token, vmUuid;

  StartVMStateEvent(this.token, this.vmUuid);
}

abstract class StartVMState {}

class InitialStartVMState extends StartVMState {}

class LoadingStartVMState extends StartVMState {}

class LoadedStartVMState extends StartVMState {
  final VMStateModel startVM;
  LoadedStartVMState(this.startVM);
}

class ErrorStartVMState extends StartVMState {
  final String error;
  ErrorStartVMState(this.error);
}

//===================

class StartVMBloc extends Bloc<StartVMEvent, StartVMState> {
  StartVMBloc() : super(InitialStartVMState()) {
    on<StartVMEvent>((event, emit) async {
      if (event is StartVMStateEvent) {
        emit(LoadingStartVMState());

        final response =
            await ApiServices.startVMState(event.token!, event.vmUuid!);

        print(response.runtimeType);

        if (response.runtimeType.toString() == 'Response<dynamic>') {
          print("status code ${response}");
          if (response.statusCode == 200) {
            print(response);
            emit(LoadedStartVMState(VMStateModel.fromJson(response.data)));
          } else {
            emit(ErrorStartVMState(response.data));
          }
        } else if (response.runtimeType.toString() == 'DioException') {
          Map<String, dynamic> errorData = response.response?.data;
          emit(ErrorStartVMState(
              AuthErrorModel.fromJson(errorData).message ?? ""));
          print(response);
        }
      }
    });
  }
}
