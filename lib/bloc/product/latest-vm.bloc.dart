
import 'package:bloc/bloc.dart';
import 'package:maxcloud/repository/instances/my-latest-vm.model.dart';
import 'package:maxcloud/services/api.services.dart';

import '../../repository/auth/login.model.dart';

abstract class LatestVMEvent {}

class FetchLatestVMEvent extends LatestVMEvent {
  final String? token;

  FetchLatestVMEvent(this.token);
}

abstract class LatestVMState {}

class InitialLatestVMState extends LatestVMState {}

class LoadingLatestVMState extends LatestVMState {}

class LoadedLatestVMState extends LatestVMState {
  final LatestVMModel latestVm;
  LoadedLatestVMState(this.latestVm);
}

class ErrorLatestVMState extends LatestVMState {
  final String error;
  ErrorLatestVMState(this.error);
}

//===================

class LatestVMBloc extends Bloc<LatestVMEvent, LatestVMState> {
  LatestVMBloc() : super(InitialLatestVMState()) {
    on<LatestVMEvent>((event, emit) async {
      if (event is FetchLatestVMEvent) {
        emit(LoadingLatestVMState());

        final response = await ApiServices.getLatestVM(event.token!);

        print(response.runtimeType);

        if (response.runtimeType.toString() == 'Response<dynamic>') {
          print("status code $response");
          if (response.statusCode == 200) {
            print(response);
            emit(LoadedLatestVMState(LatestVMModel.fromJson(response.data)));
          } else {
            emit(ErrorLatestVMState(response.data));
          }
        } else if (response.runtimeType.toString() == 'DioException') {
          Map<String, dynamic> errorData = response.response?.data;
          emit(ErrorLatestVMState(
              AuthErrorModel.fromJson(errorData).message ?? ""));
          print(response);
        }
      }
    });
  }
}
