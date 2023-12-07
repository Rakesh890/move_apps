import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'landing_event.dart';
part 'landing_state.dart';

class LandingBloc extends Bloc<LandingEvent, LandingState> {
  LandingBloc() : super(LandingInitial(tabIndex: 0)) {
    on<LandingEvent>((event, emit) {
      if(event is BottomTabChanges){
        emit(LandingInitial(tabIndex: event.tabIndex));
      }
      // TODO: implement event handler
    });
  }
}
