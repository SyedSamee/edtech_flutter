part of 'course_bloc.dart';

@immutable
sealed class CoursePlayerEvent {}

class CoursePlayerVideoEvent extends CoursePlayerEvent {
  final CoursePlayerBloc coursePlayerBloc;
  final String docId;

  CoursePlayerVideoEvent({required this.coursePlayerBloc, required this.docId});
}

class CoursePlayerBookmarkEvent extends CoursePlayerEvent {
  final String bookmarkDuration;
  final String docId;
  final CoursePlayerBloc coursePlayerBloc;
  CoursePlayerBookmarkEvent(
      {required this.docId,
      required this.bookmarkDuration,
      required this.coursePlayerBloc});
}

class CoursePlayerGetAllBookmarksEvent extends CoursePlayerEvent {
  final String docId;
  CoursePlayerGetAllBookmarksEvent({
    required this.docId,
  });
}

class CoursePlayerClaimCertificateEvent extends CoursePlayerEvent {}
