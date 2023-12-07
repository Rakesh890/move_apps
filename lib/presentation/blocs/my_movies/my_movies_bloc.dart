import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'my_movies_event.dart';
part 'my_movies_state.dart';

class MyMoviesBloc extends Bloc<MyMoviesEvent, MyMoviesState> {
  MyMoviesBloc() : super(MyMoviesInitial()) {
    on<MyMoviesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
