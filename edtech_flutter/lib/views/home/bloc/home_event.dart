part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeLoginChecker extends HomeEvent {}

class HomeAuthNavigation extends HomeEvent {
  final String routeName;

  HomeAuthNavigation({
    required this.routeName,
  });
}
