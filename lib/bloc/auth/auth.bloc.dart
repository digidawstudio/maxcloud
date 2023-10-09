import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:maxcloud/repository/auth/login.model.dart';
import 'package:maxcloud/services/api.services.dart';

abstract class AuthEvent {}

class LoginEvent extends AuthEvent {}

abstract class AuthState {}

class InitialAuthState extends AuthState {}

class LoadingAuthState extends AuthState {}

class LoadedAuthState extends AuthState {
  final LoginModel data;
  LoadedAuthState(this.data);
}

class ErrorAuthState extends AuthState {
  final LoginErrorModel error;
  ErrorAuthState(this.error);
}

//===================

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(InitialAuthState()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LoadingAuthState());

        final response = await ApiServices.login();

        if (response.runtimeType.toString() == 'Response') {
          print("status code ${response}");

          final loginResponse = jsonDecode(response.data);
          print(loginResponse.toString());
          if (response.statusCode == 200) {
            emit(LoadedAuthState(loginResponse));
          } else {
            emit(ErrorAuthState(loginResponse));
          }
        }
      }
    });
  }
}
