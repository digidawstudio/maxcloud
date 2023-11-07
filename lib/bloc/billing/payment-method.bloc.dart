
import 'package:bloc/bloc.dart';
import 'package:maxcloud/repository/billing/month-summary.model.dart';
import 'package:maxcloud/services/api.services.dart';

abstract class PaymentMethodEvent {}

class FetchPaymentMethodEvent extends PaymentMethodEvent {
  final String token;
  final int nominal;

  FetchPaymentMethodEvent(this.token, this.nominal);
}

abstract class PaymentMethodState {}

class InitialPaymentMethodState extends PaymentMethodState {}

class LoadingPaymentMethodState extends PaymentMethodState {}

class LoadedPaymentMethodState extends PaymentMethodState {
  final Map<String, dynamic> data;
  LoadedPaymentMethodState(this.data);
}

class ErrorPaymentMethodState extends PaymentMethodState {
  final MonthSummaryErrorModel error;
  ErrorPaymentMethodState(this.error);
}

//===================

class PaymentMethodBloc extends Bloc<PaymentMethodEvent, PaymentMethodState> {
  PaymentMethodBloc() : super(InitialPaymentMethodState()) {
    on<PaymentMethodEvent>((event, emit) async {
      print(event.runtimeType);
      if (event is FetchPaymentMethodEvent) {
        emit(LoadingPaymentMethodState());

        final response =
            await ApiServices.getPaymentMethods(event.token, event.nominal);

        print(response.runtimeType);

        if (response.runtimeType.toString() == 'Response<dynamic>') {
          print("status code $response");
          if (response.statusCode == 200) {
            print(response);
            emit(LoadedPaymentMethodState(response.data["data"]));
          } else {
            emit(ErrorPaymentMethodState(response.data));
          }
        } else if (response.runtimeType.toString() == 'DioException') {
          Map<String, dynamic> errorData = response.response?.data;
          emit(ErrorPaymentMethodState(
              MonthSummaryErrorModel.fromJson(errorData)));
          print(response);
        }
      }
    });
  }
}
