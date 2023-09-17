import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

abstract class ProductEvent {}

class FetchProductEvent extends ProductEvent {}

abstract class ProductState{}

class InitialProductState extends ProductState{}
class LoadingProductState extends ProductState{}

class LoadedProductState extends ProductState{
  final List products;
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
      if(event is FetchProductEvent) {
        emit(LoadingProductState());

        try {
          final dio = Dio();
          final response = await dio.get('https://fakestoreapi.com/products');

          print("status code ${response.statusCode}");
          if (response.statusCode == 200) {
            final product = response.data;
            emit(LoadedProductState(product));
          } else {
            emit(ErrorProductState('Failed to load products data'));
          }
        } on DioException catch (dioError) {
          emit(ErrorProductState(dioError.message ?? "DIO: Something went wrong: ${dioError.stackTrace}"));
        } on FormatException catch (formatException) {
          print(formatException.toString());
          emit(ErrorProductState(formatException.message));
        }
      }
    });
  }
}