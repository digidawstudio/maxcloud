
import 'package:bloc/bloc.dart';
import 'package:maxcloud/services/api.services.dart';

import '../../repository/auth/login.model.dart';
import '../../repository/instances/rrd-data.model.dart';

abstract class RRDDataEvent {}

class FetchRRDDataEvent extends RRDDataEvent {
  final String? token;
  final String? vmUuid;
  final String? period;

  FetchRRDDataEvent(this.token, this.vmUuid, this.period);
}

abstract class RRDDataState {}

class InitialRRDDataState extends RRDDataState {}

class LoadingRRDDataState extends RRDDataState {}

class LoadedRRDDataState extends RRDDataState {
  final RRDModel rrdData;
  LoadedRRDDataState(this.rrdData);
}

class ErrorRRDDataState extends RRDDataState {
  final String error;
  ErrorRRDDataState(this.error);
}

//===================

class RRDDataBloc extends Bloc<RRDDataEvent, RRDDataState> {
  RRDDataBloc() : super(InitialRRDDataState()) {
    on<RRDDataEvent>((event, emit) async {
      if (event is FetchRRDDataEvent) {
        emit(LoadingRRDDataState());

        final response = await ApiServices.getRRDData(
            event.token!, event.vmUuid!, event.period!);

        print(response.runtimeType);

        if (response.runtimeType.toString() == 'Response<dynamic>') {
          print("status code $response");
          if (response.statusCode == 200) {
            print(response);
            emit(LoadedRRDDataState(RRDModel.fromJson(response.data)));
          } else {
            emit(ErrorRRDDataState(response.data));
          }
        } else if (response.runtimeType.toString() == 'DioException') {
          Map<String, dynamic> errorData = response.response?.data;
          emit(ErrorRRDDataState(
              AuthErrorModel.fromJson(errorData).message ?? ""));
          print(response);
        }
      }
    });
  }
}
