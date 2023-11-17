import 'package:bloc/bloc.dart';

abstract class NavigationEvent {}

class SetNavigatorIndexEvent extends NavigationEvent {
  final int index;

  SetNavigatorIndexEvent(this.index);
}

abstract class NavigationState {}

class InitialNavigationState extends NavigationState {
  final int index = 0;
}

class LoadedNavigationState extends NavigationState {
  final int index;
  LoadedNavigationState(this.index);
}

//===================

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(InitialNavigationState()) {
    on<NavigationEvent>((event, emit) async {
      if (event is SetNavigatorIndexEvent) {
        emit(LoadedNavigationState(event.index));
      }
    });
  }
}
