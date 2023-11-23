import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:edtech_flutter/controllers/course_player_controller/course_player_controller.dart';
import 'package:meta/meta.dart';

part 'course_event.dart';
part 'course_state.dart';

class CoursePlayerBloc extends Bloc<CoursePlayerEvent, CoursePlayerState> {
  CoursePlayerBloc() : super(CoursePlayerLoadingState()) {
    on<CoursePlayerEvent>((event, emit) {});
    on<CoursePlayerVideoEvent>(coursePlayerVideoEvent);
    on<CoursePlayerBookmarkEvent>(coursePlayerBookmarkEvent);
    on<CoursePlayerGetAllBookmarksEvent>(coursePlayerGetAllBookmarks);
  }

  FutureOr<void> coursePlayerVideoEvent(
      CoursePlayerVideoEvent event, Emitter<CoursePlayerState> emit) {
    event.coursePlayerBloc
        .add(CoursePlayerGetAllBookmarksEvent(docId: event.docId));
    emit(CourseVideoPlayerState());
  }

  FutureOr<void> coursePlayerGetAllBookmarks(
      CoursePlayerGetAllBookmarksEvent event,
      Emitter<CoursePlayerState> emit) async {
    emit(CoursePlayerInitial());
    var bookmarkRespons =
        await CoursePlayerController().GetAllBookmarks(event.docId);

    if (bookmarkRespons is List) {
      emit(CoursePlayerBookmarkState(bookmarks: bookmarkRespons));
    } else if (bookmarkRespons is String) {
      emit(CoursePlayerMsgState(isError: true, msg: bookmarkRespons));
    } else {
      emit(CoursePlayerMsgState(isError: true, msg: "Something went wrong"));
    }
  }

  FutureOr<void> coursePlayerBookmarkEvent(
      CoursePlayerBookmarkEvent event, Emitter<CoursePlayerState> emit) async {
    var bookmarkResponse = await CoursePlayerController()
        .bookmarkDuration(event.docId, event.bookmarkDuration);

    if (bookmarkResponse == true) {
      event.coursePlayerBloc
          .add(CoursePlayerGetAllBookmarksEvent(docId: event.docId));
      //called with the bloc get all event
    } else if (bookmarkResponse is String) {
      emit(CoursePlayerMsgState(isError: true, msg: bookmarkResponse));
    } else {
      emit(CoursePlayerMsgState(isError: true, msg: "Something went wrong"));
    }
  }
}
