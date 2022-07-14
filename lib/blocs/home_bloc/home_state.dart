part of 'home_bloc.dart';

@immutable
class HomeState {
  final int selectedIndex;
  final String title;
  final Widget screen;
  const HomeState({
    required this.selectedIndex,
    required this.title,
    required this.screen,
  });
}
