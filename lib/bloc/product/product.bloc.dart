import 'package:bloc/bloc.dart';
import 'package:maxcloud/repository/instances/my-virtual-machines.model.dart';
import 'package:maxcloud/services/api.services.dart';

import '../../repository/auth/login.model.dart';

abstract class ProductEvent {}

class FetchProductEvent extends ProductEvent {
  final String? token, status;
  final int limit, page;

  FetchProductEvent(this.token, this.status, this.limit, this.page);
}

abstract class ProductState {}

class InitialProductState extends ProductState {}

class LoadingProductState extends ProductState {}

class LoadedProductState extends ProductState {
  final MyVirtualMachines products;
  LoadedProductState(this.products);
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

        final response = await ApiServices.getMyInstances(
            event.token!, event.status!, event.limit, event.page);

        print(response.runtimeType);

        if (response.runtimeType.toString() == 'Response<dynamic>') {
          print("status code $response");
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
      }
    });
  }
}
