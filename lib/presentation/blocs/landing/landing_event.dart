part of 'landing_bloc.dart';

@immutable
abstract class LandingEvent {}

class BottomTabChanges extends LandingEvent{
  final int tabIndex ;

  BottomTabChanges({required this.tabIndex});
}
