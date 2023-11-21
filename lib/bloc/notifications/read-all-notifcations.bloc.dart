import 'package:bloc/bloc.dart';
import 'package:maxcloud/repository/notifications/notifications.model.dart';
import 'package:maxcloud/services/api.services.dart';

abstract class ReadAllNotificationEvent {}

class PostReadAllNotificationEvent extends ReadAllNotificationEvent {
  final String token;

  PostReadAllNotificationEvent(this.token);
}

abstract class ReadAllNotificationState {}

class InitialReadAllNotificationState extends ReadAllNotificationState {}

class LoadingReadAllNotificationState extends ReadAllNotificationState {}

class LoadedReadAllNotificationState extends ReadAllNotificationState {}

// class ErrorReadAllNotificationState extends ReadAllNotificationState {
//   // final MonthSummaryErrorModel error;
//   ErrorReadAllNotificationState(this.error);
// }

//===================

class ReadAllNotificationBloc
    extends Bloc<ReadAllNotificationEvent, ReadAllNotificationState> {
  ReadAllNotificationBloc() : super(InitialReadAllNotificationState()) {
    on<ReadAllNotificationEvent>((event, emit) async {
      print(event.runtimeType);
      if (event is PostReadAllNotificationEvent) {
        emit(LoadingReadAllNotificationState());

        final response = await ApiServices.readAllNotifications(event.token);

        print(response.runtimeType);

        if (response.runtimeType.toString() == 'Response<dynamic>') {
          print("status code $response");
          if (response.statusCode == 200) {
            print(response.data);
            emit(LoadedReadAllNotificationState());
          } else {
            // emit(ErrorReadAllNotificationState(response.data));
          }
        } else if (response.runtimeType.toString() == 'DioException') {
          Map<String, dynamic> errorData = response.response?.data;
          // emit(ErrorReadAllNotificationState(
          //     MonthSummaryErrorModel.fromJson(errorData)));
          print(response);
        }
      }
    });
  }
}
