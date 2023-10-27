import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:maxcloud/repository/instances/my-latest-vm.model.dart';
import 'package:maxcloud/repository/instances/my-virtual-machines.model.dart';
import 'package:maxcloud/repository/instances/vm-detail.model.dart';
import 'package:maxcloud/services/api.services.dart';

import '../../repository/auth/login.model.dart';
import '../../repository/instances/total-resource.model.dart';

abstract class TotalResourceEvent {}

class FetchTotalResourceEvent extends TotalResourceEvent {
  final String? token;

  FetchTotalResourceEvent(this.token);
}

abstract class TotalResourceState {}

class InitialTotalResourceState extends TotalResourceState {}

class LoadingTotalResourceState extends TotalResourceState {}

class LoadedTotalResourceState extends TotalResourceState {
  final TotalResourceModel totalResource;
  LoadedTotalResourceState(this.totalResource);
}

class ErrorTotalResourceState extends TotalResourceState {
  final String error;
  ErrorTotalResourceState(this.error);
}

//===================

class TotalResourceBloc extends Bloc<TotalResourceEvent, TotalResourceState> {
  TotalResourceBloc() : super(InitialTotalResourceState()) {
    on<TotalResourceEvent>((event, emit) async {
      if (event is FetchTotalResourceEvent) {
        emit(LoadingTotalResourceState());

        final response = await ApiServices.getTotalResource(event.token!);

        print(response.runtimeType);

        if (response.runtimeType.toString() == 'Response<dynamic>') {
          print("status code ${response}");
          if (response.statusCode == 200) {
            print(response);
            emit(LoadedTotalResourceState(
                TotalResourceModel.fromJson(response.data)));
          } else {
            emit(ErrorTotalResourceState(response.data));
          }
        } else if (response.runtimeType.toString() == 'DioException') {
          Map<String, dynamic> errorData = response.response?.data;
          emit(ErrorTotalResourceState(
              AuthErrorModel.fromJson(errorData).message ?? ""));
          print(response);
        }
      }
    });
  }
}
