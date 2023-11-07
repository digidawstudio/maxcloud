
import 'package:bloc/bloc.dart';
import 'package:maxcloud/repository/instances/vm-state.model.dart';
import 'package:maxcloud/services/api.services.dart';

import '../../repository/auth/login.model.dart';

abstract class RestartVMEvent {}

class RestartVMStateEvent extends RestartVMEvent {
  final String? token, vmUuid;

  RestartVMStateEvent(this.token, this.vmUuid);
}

abstract class RestartVMState {}

class InitialRestartVMState extends RestartVMState {}

class LoadingRestartVMState extends RestartVMState {}

class LoadedRestartVMState extends RestartVMState {
  final VMStateModel startVM;
  LoadedRestartVMState(this.startVM);
}

class ErrorRestartVMState extends RestartVMState {
  final String error;
  ErrorRestartVMState(this.error);
}

//===================

class RestartVMBloc extends Bloc<RestartVMEvent, RestartVMState> {
  RestartVMBloc() : super(InitialRestartVMState()) {
    on<RestartVMEvent>((event, emit) async {
      if (event is RestartVMStateEvent) {
        emit(LoadingRestartVMState());

        final response =
            await ApiServices.restartVMState(event.token!, event.vmUuid!);

        print(response.runtimeType);

        if (response.runtimeType.toString() == 'Response<dynamic>') {
          print("status code $response");
          if (response.statusCode == 200) {
            print(response);
            emit(LoadedRestartVMState(VMStateModel.fromJson(response.data)));
          } else {
            emit(ErrorRestartVMState(response.data));
          }
        } else if (response.runtimeType.toString() == 'DioException') {
          Map<String, dynamic> errorData = response.response?.data;
          emit(ErrorRestartVMState(
              AuthErrorModel.fromJson(errorData).message ?? ""));
          print(response);
        }
      }
    });
  }
}
