part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardState {}

final class DashboardInitialState extends DashboardState {
  final List<DashboardCourseModel> allCourses;
  final List<DashboardCourseModel> enrolledCourses;

  DashboardInitialState(
      {required this.allCourses, required this.enrolledCourses});
}

final class DashboardLoadingState extends DashboardState {}

final class DashboardMsgState extends DashboardState {
  final bool isError;
  final String msg;
  DashboardMsgState({required this.isError, required this.msg});
}
