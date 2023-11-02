import 'package:bloc/bloc.dart';
import 'package:maxcloud/repository/tickets.model.dart';
import 'package:maxcloud/repository/tickets/message.model.dart';
import 'package:maxcloud/repository/tickets/ticketsconv.model.dart';
import 'package:maxcloud/services/api.services.dart';

abstract class HelpDeskEvent {}

class FetchHelpDeskItemsEvent extends HelpDeskEvent {
  final String token;
  final int page;

  FetchHelpDeskItemsEvent(this.token, this.page);
}

abstract class FetchHelpDeskItemsState {}

class InitialFetchHelpDeskItemsState extends FetchHelpDeskItemsState {}

class LoadingFetchHelpDeskItemsState extends FetchHelpDeskItemsState {}

class LoadedFetchHelpDeskItemsState extends FetchHelpDeskItemsState {
  final TicketsModel data;
  LoadedFetchHelpDeskItemsState(this.data);
}

class ErrorFetchHelpDeskState extends FetchHelpDeskItemsState {
  Map<String, dynamic> error;
  ErrorFetchHelpDeskState(this.error);
}

//===================

class HelpDeskBloc extends Bloc<HelpDeskEvent, FetchHelpDeskItemsState> {
  HelpDeskBloc() : super(InitialFetchHelpDeskItemsState()) {
    on<HelpDeskEvent>((event, emit) async {
      if (event is FetchHelpDeskItemsEvent) {
        emit(LoadingFetchHelpDeskItemsState());

        final response =
            await ApiServices.fetchHelpDeskItems(event.token, page: event.page);

        print(response.runtimeType);

        if (response.runtimeType.toString() == 'Response<dynamic>') {
          print("status code ${response}");
          if (response.statusCode == 200) {
            print(response.data);
            emit(LoadedFetchHelpDeskItemsState(
                TicketsModel.fromJson(response.data)));
          } else {
            emit(ErrorFetchHelpDeskState(response.data));
          }
        } else if (response.runtimeType.toString() == 'DioException') {
          Map<String, dynamic> errorData = response.response?.data;
          emit(ErrorFetchHelpDeskState(errorData));
          print(response);
        }
      }
    });
  }
}

//======

class FetchConversationEvent extends HelpDeskEvent {
  final String token, convToken;
  final int page;

  FetchConversationEvent(this.token, this.page, this.convToken);
}

abstract class FetchConversationState {}

class InitialFetchConversationState extends FetchConversationState {}

class LoadingFetchConversationState extends FetchConversationState {}

class LoadedFetchConversationState extends FetchConversationState {
  final ConversationModel data;
  LoadedFetchConversationState(this.data);
}

class ErrorFetchConversationState extends FetchConversationState {
  Map<String, dynamic> error;
  ErrorFetchConversationState(this.error);
}

class TicketConversationBloc extends Bloc<HelpDeskEvent, FetchConversationState> {
  TicketConversationBloc() : super(InitialFetchConversationState()) {
    on<HelpDeskEvent>((event, emit) async {
      if (event is FetchConversationEvent) {
        emit(LoadingFetchConversationState());

        final response =
            await ApiServices.fetchConversations(event.token, event.convToken, page: event.page);

        print(response.runtimeType);

        if (response.runtimeType.toString() == 'Response<dynamic>') {
          print("status code ${response}");
          if (response.statusCode == 200) {
            print(response.data);
            emit(LoadedFetchConversationState(
                ConversationModel.fromJson(response.data)));
          } else {
            emit(ErrorFetchConversationState(response.data));
          }
        } else if (response.runtimeType.toString() == 'DioException') {
          Map<String, dynamic> errorData = response.response?.data;
          emit(ErrorFetchConversationState(errorData));
          print(response);
        }
      }
    });
  }
}

class SendMessageEvent extends HelpDeskEvent {
  final String token, convToken, message;
  final List<String> attachments;

  SendMessageEvent(this.token, this.convToken, this.message, {this.attachments = const []});
}

abstract class SendMessageState {}

class InitialSendMessageState extends SendMessageState {}

class LoadingSendMessageState extends SendMessageState {}

class LoadedSendMessageState extends SendMessageState {
  final MessageModel data;
  LoadedSendMessageState(this.data);
}

class ErrorSendMessageState extends SendMessageState {
  Map<String, dynamic> error;
  ErrorSendMessageState(this.error);
}

class SendMessageBloc extends Bloc<HelpDeskEvent, SendMessageState> {
  SendMessageBloc() : super(InitialSendMessageState()) {
    on<HelpDeskEvent>((event, emit) async {
      if (event is SendMessageEvent) {
        emit(LoadingSendMessageState());

        final response =
            await ApiServices.sendMessage(event.token, event.convToken, event.message, attachments: event.attachments);

        print(response.runtimeType);

        if (response.runtimeType.toString() == 'Response<dynamic>') {
          print("status code ${response}");
          if (response.statusCode == 200) {
            print(response.data);
            emit(LoadedSendMessageState(
                MessageModel.fromJson(response.data)));
          } else {
            emit(ErrorSendMessageState(response.data));
          }
        } else if (response.runtimeType.toString() == 'DioException') {
          Map<String, dynamic> errorData = response.response?.data;
          emit(ErrorSendMessageState(errorData));
          print(response);
        }
      }
    });
  }
}
