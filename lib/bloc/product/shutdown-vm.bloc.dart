import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:maxcloud/repository/instances/vm-state.model.dart';
import 'package:maxcloud/services/api.services.dart';

import '../../repository/auth/login.model.dart';

abstract class ShutdownVMEvent {}

class ShutdownVMStateEvent extends ShutdownVMEvent {
  final String? token, vmUuid;

  ShutdownVMStateEvent(this.token, this.vmUuid);
}

abstract class ShutdownVMState {}

class InitialShutdownVMState extends ShutdownVMState {}

class LoadingShutdownVMState extends ShutdownVMState {}

class LoadedShutdownVMState extends ShutdownVMState {
  final VMStateModel startVM;
  LoadedShutdownVMState(this.startVM);
}

class ErrorShutdownVMState extends ShutdownVMState {
  final String error;
  ErrorShutdownVMState(this.error);
}

//===================

class ShutdownVMBloc extends Bloc<ShutdownVMEvent, ShutdownVMState> {
  ShutdownVMBloc() : super(InitialShutdownVMState()) {
    on<ShutdownVMEvent>((event, emit) async {
      if (event is ShutdownVMStateEvent) {
        emit(LoadingShutdownVMState());

        final response =
            await ApiServices.shutdownVMState(event.token!, event.vmUuid!);

        print(response.runtimeType);

        if (response.runtimeType.toString() == 'Response<dynamic>') {
          print("status code ${response}");
          if (response.statusCode == 200) {
            print(response);
            emit(LoadedShutdownVMState(VMStateModel.fromJson(response.data)));
          } else {
            emit(ErrorShutdownVMState(response.data));
          }
        } else if (response.runtimeType.toString() == 'DioException') {
          Map<String, dynamic> errorData = response.response?.data;
          emit(ErrorShutdownVMState(
              AuthErrorModel.fromJson(errorData).message ?? ""));
          print(response);
        }
      }
    });
  }
}
