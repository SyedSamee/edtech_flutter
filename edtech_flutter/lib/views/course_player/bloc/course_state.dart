part of 'course_bloc.dart';

@immutable
sealed class CoursePlayerState {}

final class CoursePlayerInitial extends CoursePlayerState {}

final class CoursePlayerLoadingState extends CoursePlayerState {}

final class CoursePlayerMsgState extends CoursePlayerState {
  final String msg;
  final bool isError;
  CoursePlayerMsgState({required this.isError, required this.msg});
}

final class CourseVideoPlayerState extends CoursePlayerState {}

final class CoursePlayerBookmarkState extends CoursePlayerState {
  final List bookmarks;
  CoursePlayerBookmarkState({required this.bookmarks});
}
