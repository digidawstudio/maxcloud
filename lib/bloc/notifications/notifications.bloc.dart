import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:maxcloud/repository/billing/month-summary.model.dart';
import 'package:maxcloud/repository/notifications/notifications.model.dart';
import 'package:maxcloud/services/api.services.dart';

abstract class NotificationEvent {}

class FetchNotificationEvent extends NotificationEvent {
  final String token, type;
  final int page, limit;

  FetchNotificationEvent(this.token, this.type, this.page, this.limit);
}

abstract class NotificationState {}

class InitialNotificationState extends NotificationState {}

class LoadingNotificationState extends NotificationState {}

class LoadedNotificationState extends NotificationState {
  final NotificationModel data;
  LoadedNotificationState(this.data);
}

// class ErrorNotificationState extends NotificationState {
//   // final MonthSummaryErrorModel error;
//   ErrorNotificationState(this.error);
// }

//===================

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(InitialNotificationState()) {
    on<NotificationEvent>((event, emit) async {
      print(event.runtimeType);
      if (event is FetchNotificationEvent) {
        emit(LoadingNotificationState());

        final response = await ApiServices.getNotifications(
            event.token, event.type, event.page, event.limit);

        print(response.runtimeType);

        if (response.runtimeType.toString() == 'Response<dynamic>') {
          print("status code ${response}");
          if (response.statusCode == 200) {
            print(response.data);
            emit(LoadedNotificationState(
                NotificationModel.fromJson(response.data)));
          } else {
            // emit(ErrorNotificationState(response.data));
          }
        } else if (response.runtimeType.toString() == 'DioException') {
          Map<String, dynamic> errorData = response.response?.data;
          // emit(ErrorNotificationState(
          //     MonthSummaryErrorModel.fromJson(errorData)));
          print(response);
        }
      }
    });
  }
}
