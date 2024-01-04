part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class FetchMoviesEvent extends HomeEvent{}

// ignore: must_be_immutable
class CarosuleScrollingEvent extends HomeEvent{
  int index;

  CarosuleScrollingEvent({required this.index});
}
