part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {
  const HomeEvent();
}

@immutable
class UpdateBottomBarIndex extends HomeEvent {
  final int newIndex;

  const UpdateBottomBarIndex({required this.newIndex});
}
