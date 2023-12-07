part of 'landing_bloc.dart';

@immutable
abstract class LandingState {
  final int tabIndex;

  LandingState({required this.tabIndex});
}

class LandingInitial extends LandingState {
  LandingInitial({required super.tabIndex});
}
