import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:maxcloud/repository/auth/login.model.dart';
import 'package:maxcloud/repository/auth/otp.model.dart';
import 'package:maxcloud/services/api.services.dart';

abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent(this.email, this.password);
}

class RequestOtpEvent extends AuthEvent {
  final String credentials;

  RequestOtpEvent(this.credentials);
}

class ValidateOtpEvent extends AuthEvent {
  final String credential;
  final String code;

  ValidateOtpEvent(this.credential, this.code);
}

abstract class AuthState {}

class InitialAuthState extends AuthState {}

class LoadingAuthState extends AuthState {}

class LoadedAuthState extends AuthState {
  final LoginModel data;
  LoadedAuthState(this.data);
}

class OtpReceivedState extends AuthState {
  final OtpModel data;
  OtpReceivedState(this.data);
}

class OtpValidatedState extends AuthState {
  final OtpValidate data;
  OtpValidatedState(this.data);
}

class ErrorAuthState extends AuthState {
  final AuthErrorModel error;
  ErrorAuthState(this.error);
}

//===================

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(InitialAuthState()) {
    on<AuthEvent>((event, emit) async {
      print(event.runtimeType);
      if (event is LoginEvent) {
        emit(LoadingAuthState());

        final response = await ApiServices.login(event.email, event.password);

        print(response.runtimeType);

        if (response.runtimeType.toString() == 'Response<dynamic>') {
          print("status code ${response}");
          if (response.statusCode == 200) {
            print(response);
            emit(LoadedAuthState(LoginModel.fromJson(response.data)));
          } else {
            emit(ErrorAuthState(response.data));
          }
        } else if (response.runtimeType.toString() == 'DioException') {
          Map<String, dynamic> errorData = response.response?.data;
          emit(ErrorAuthState(AuthErrorModel.fromJson(errorData)));
          print(response);
        }
      } else if (event is RequestOtpEvent) {
        emit(LoadingAuthState());

        final response = await ApiServices.requestOtp(event.credentials);

        if (response.runtimeType.toString() == 'Response<dynamic>') {
          print("status code ${response}");
          if (response.statusCode == 200) {
            print(response);
            emit(OtpReceivedState(OtpModel.fromJson(response.data)));
          } else {
            emit(ErrorAuthState(response.data));
          }
        } else if (response.runtimeType.toString() == 'DioException') {
          Map<String, dynamic> errorData = response.response?.data;
          emit(ErrorAuthState(AuthErrorModel.fromJson(errorData)));
          print(response);
        }
      } else if (event is ValidateOtpEvent) {
        emit(LoadingAuthState());

        final response =
            await ApiServices.validateOtp(event.credential, event.code);

        if (response.runtimeType.toString() == 'Response<dynamic>') {
          if ((response as Response<dynamic>).statusCode == 200) {
            emit(OtpValidatedState(OtpValidate.fromJson(response.data)));
          } else {
            emit(ErrorAuthState(response.data));
          }
        } else if (response.runtimeType.toString() == 'DioException') {
          Map<String, dynamic> errorData = response.response?.data;
          emit(ErrorAuthState(AuthErrorModel.fromJson(errorData)));
        }
      }
    });
  }
}
