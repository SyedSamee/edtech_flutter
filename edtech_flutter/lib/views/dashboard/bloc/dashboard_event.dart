part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardEvent {}

class DashboardInitialEvent extends DashboardEvent {}

class DashboardEnrollCourseEvent extends DashboardEvent {
  final String id;
  final DashboardBloc dashboardBloc;
  DashboardEnrollCourseEvent({required this.id, required this.dashboardBloc});
}

class DashboardContinueCourse extends DashboardEvent {
  final String docId;
  final String videoUrl;
  final String name;

  DashboardContinueCourse(
      {required this.docId, required this.videoUrl, required this.name});
}
