import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

abstract class UserEvent {}

class FetchUserEvent extends UserEvent {}

abstract class UserState{}

class InitialUserState extends UserState{}
class LoadingUserState extends UserState{}

class LoadedUserState extends UserState{
  final List user;
  LoadedUserState(this.user);
}

class ErrorUserState extends UserState {
  final String error;
  ErrorUserState(this.error);
}

//===================

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(InitialUserState()) {

    on<UserEvent>((event, emit) async {
      if(event is FetchUserEvent) {
        emit(LoadingUserState());

        try {
          final dio = Dio();
          final response = await dio.get('https://fakestoreapi.com/users');

          print("status code ${response.statusCode}");
          if (response.statusCode == 200) {
            final user = response.data;
            emit(LoadedUserState(user));
          } else {
            emit(ErrorUserState('Failed to load user data'));
          }
        } on DioException catch (dioError) {
          emit(ErrorUserState(dioError.message ?? "DIO: Something went wrong: ${dioError.stackTrace}"));
        } on FormatException catch (formatException) {
          print(formatException.toString());
          emit(ErrorUserState(formatException.message));
        }
      }
    });
  }
}