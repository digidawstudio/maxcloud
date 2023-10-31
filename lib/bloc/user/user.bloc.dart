import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:maxcloud/repository/profile/updateprofile.model.dart';
import 'package:maxcloud/services/api.services.dart';

abstract class UserEvent {}

class FetchUserEvent extends UserEvent {}

class UpdateUserEvent extends UserEvent {
  final String token;
  final UpdateProfile body;

  UpdateUserEvent(this.token, this.body);
}

abstract class UserState {}

abstract class UpdateUserState {}

class InitialUpdateState extends UpdateUserState {}

class LoadingUpdateState extends UpdateUserState {}

class SavedUpdateState extends UpdateUserState {
  final UpdatedProfile profile;

  SavedUpdateState(this.profile);
}

class ErrorUpdateState extends UpdateUserState {
  final UpdateProfileErrorModel error;
  ErrorUpdateState(this.error);
}

class InitialUserState extends UserState {}

class LoadingUserState extends UserState {}

class LoadedUserState extends UserState {
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
      if (event is FetchUserEvent) {
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
          emit(ErrorUserState(dioError.message ??
              "DIO: Something went wrong: ${dioError.stackTrace}"));
        } on FormatException catch (formatException) {
          print(formatException.toString());
          emit(ErrorUserState(formatException.message));
        }
      }
    });
  }
}

class UpdateUserBloc extends Bloc<UserEvent, UpdateUserState> {
  UpdateUserBloc() : super(InitialUpdateState()) {
    on<UserEvent>((event, emit) async {
      if (event is UpdateUserEvent) {
        emit(LoadingUpdateState());

        final response =
            await ApiServices.updateProfile(event.token, event.body);

        if (response.runtimeType.toString() == 'Response<dynamic>') {
          print("status code get profile $response");
          if (response.statusCode == 200) {
            print("get profile data:  $response");
            emit(SavedUpdateState(UpdatedProfile.fromJson(response.data)));
          } else {
            emit(ErrorUpdateState(response.data));
          }
        } else if (response.runtimeType.toString() == 'DioException') {
          Map<String, dynamic> errorData = response.response?.data;
          emit(ErrorUpdateState(UpdateProfileErrorModel.fromJson(errorData)));
          print(response);
        }
      }
    });
  }
}
