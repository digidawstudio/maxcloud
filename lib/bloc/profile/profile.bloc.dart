import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:maxcloud/services/api.services.dart';

import '../../repository/profile/profile.model.dart';

abstract class ProfileEvent {}

class FetchProfileEvent extends ProfileEvent {
  final String token;

  FetchProfileEvent(this.token);
}

abstract class ProfileState {}

class InitialProfileState extends ProfileState {}

class LoadingProfileState extends ProfileState {}

class LoadedProfileState extends ProfileState {
  final ProfileModel data;
  LoadedProfileState(this.data);
}

class ErrorProfileState extends ProfileState {
  final ProfileErrorModel error;
  ErrorProfileState(this.error);
}

//===================

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(InitialProfileState()) {
    on<ProfileEvent>((event, emit) async {
      print(event.runtimeType);
      if (event is FetchProfileEvent) {
        print('masuk sini ga?');
        emit(LoadingProfileState());

        final response = await ApiServices.getProfile(event.token);

        print(response.runtimeType);

        if (response.runtimeType.toString() == 'Response<dynamic>') {
          print("status code get profile ${response}");
          if (response.statusCode == 200) {
            print("get profile data:  ${response}");
            emit(LoadedProfileState(ProfileModel.fromJson(response.data)));
          } else {
            emit(ErrorProfileState(response.data));
          }
        } else if (response.runtimeType.toString() == 'DioException') {
          Map<String, dynamic> errorData = response.response?.data;
          emit(ErrorProfileState(ProfileErrorModel.fromJson(errorData)));
          print(response);
        }
      }
    });
  }
}
