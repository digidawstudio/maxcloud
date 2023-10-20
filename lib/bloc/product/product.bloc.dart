import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:maxcloud/repository/instances/my-latest-vm.model.dart';
import 'package:maxcloud/repository/instances/my-virtual-machines.model.dart';
import 'package:maxcloud/repository/instances/vm-detail.model.dart';
import 'package:maxcloud/services/api.services.dart';

import '../../repository/auth/login.model.dart';
import '../../repository/instances/total-resource.model.dart';

abstract class ProductEvent {}

class FetchProductEvent extends ProductEvent {
  final String? token;

  FetchProductEvent(this.token);
}

class FetchLatestVMEvent extends ProductEvent {
  final String? token;

  FetchLatestVMEvent(this.token);
}

class FetchTotalResourceEvent extends ProductEvent {
  final String? token;

  FetchTotalResourceEvent(this.token);
}

class FetchVMDetailEvent extends ProductEvent {
  final String? token;

  FetchVMDetailEvent(this.token);
}

abstract class ProductState {}

class InitialProductState extends ProductState {}

class InitialTotalResourceState extends ProductState {}

class LoadingProductState extends ProductState {}

class LoadingTotalResourceState extends ProductState {}

class LoadingVMDetailState extends ProductState {}

class LoadedProductState extends ProductState {
  final MyVirtualMachines products;
  LoadedProductState(this.products);
}

class LoadedLatestVMState extends ProductState {
  final LatestVMModel latestVm;
  LoadedLatestVMState(this.latestVm);
}

class LoadedTotalResourceState extends ProductState {
  final TotalResourceModel totalResource;
  LoadedTotalResourceState(this.totalResource);
}

class LoadedVMDetailState extends ProductState {
  final VMDetailModel vmDetail;
  LoadedVMDetailState(this.vmDetail);
}

class ErrorProductState extends ProductState {
  final String error;
  ErrorProductState(this.error);
}

//===================

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(InitialProductState()) {
    on<ProductEvent>((event, emit) async {
      if (event is FetchProductEvent) {
        emit(LoadingProductState());

        final response = await ApiServices.getMyInstances(event.token!);

        print(response.runtimeType);

        if (response.runtimeType.toString() == 'Response<dynamic>') {
          print("status code ${response}");
          if (response.statusCode == 200) {
            print(response);
            emit(LoadedProductState(MyVirtualMachines.fromJson(response.data)));
          } else {
            emit(ErrorProductState(response.data));
          }
        } else if (response.runtimeType.toString() == 'DioException') {
          Map<String, dynamic> errorData = response.response?.data;
          emit(ErrorProductState(
              AuthErrorModel.fromJson(errorData).message ?? ""));
          print(response);
        }
      } else if (event is FetchLatestVMEvent) {
        emit(LoadingProductState());

        final response = await ApiServices.getLatestVM(event.token!);

        print(response.runtimeType);

        if (response.runtimeType.toString() == 'Response<dynamic>') {
          print("status code ${response}");
          if (response.statusCode == 200) {
            print(response);
            emit(LoadedLatestVMState(LatestVMModel.fromJson(response.data)));
          } else {
            emit(ErrorProductState(response.data));
          }
        } else if (response.runtimeType.toString() == 'DioException') {
          Map<String, dynamic> errorData = response.response?.data;
          emit(ErrorProductState(
              AuthErrorModel.fromJson(errorData).message ?? ""));
          print(response);
        }
      } else if (event is FetchTotalResourceEvent) {
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
            emit(ErrorProductState(response.data));
          }
        } else if (response.runtimeType.toString() == 'DioException') {
          Map<String, dynamic> errorData = response.response?.data;
          emit(ErrorProductState(
              AuthErrorModel.fromJson(errorData).message ?? ""));
          print(response);
        }
      } else if (event is FetchVMDetailEvent) {
        emit(LoadingVMDetailState());

        final response = await ApiServices.getTotalResource(event.token!);

        print(response.runtimeType);

        if (response.runtimeType.toString() == 'Response<dynamic>') {
          print("status code ${response}");
          if (response.statusCode == 200) {
            print(response);
            emit(LoadedTotalResourceState(
                TotalResourceModel.fromJson(response.data)));
          } else {
            emit(ErrorProductState(response.data));
          }
        } else if (response.runtimeType.toString() == 'DioException') {
          Map<String, dynamic> errorData = response.response?.data;
          emit(ErrorProductState(
              AuthErrorModel.fromJson(errorData).message ?? ""));
          print(response);
        }
      }
    });
  }
}
