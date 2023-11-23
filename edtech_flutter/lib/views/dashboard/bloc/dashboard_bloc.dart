import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:edtech_flutter/controllers/dashboard_controller/dashboard_controller.dart';
import 'package:edtech_flutter/model/dashboard/dahsboard_course_model.dart';
import 'package:edtech_flutter/views/course_player/courseplayer_screen.dart';
import 'package:meta/meta.dart';
import 'package:get/get.dart' as _get;
part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardLoadingState()) {
    on<DashboardEvent>((event, emit) {});
    on<DashboardInitialEvent>(dashboardInitialEvent);
    on<DashboardEnrollCourseEvent>(enrollCourseEvent);
    on<DashboardContinueCourse>(dashboardContinueCourse);
  }

  FutureOr<void> dashboardInitialEvent(
      DashboardInitialEvent event, Emitter<DashboardState> emit) async {
    emit(DashboardLoadingState());
    var allCourseResponse = await DashboardController().getAllCourses();
    var enrollCourseResponse = await DashboardController().getEnrolledCourses();

    if (allCourseResponse is List<DashboardCourseModel> &&
        enrollCourseResponse is List<DashboardCourseModel>) {
      emit(DashboardInitialState(
          allCourses: allCourseResponse,
          enrolledCourses: enrollCourseResponse));
    } else if (allCourseResponse is String && enrollCourseResponse is String) {
      //if try catch occure then we will show the error
      emit(DashboardMsgState(isError: true, msg: allCourseResponse));
    } else {
      emit(DashboardMsgState(isError: true, msg: "Something went wrong"));
    }
  }

  FutureOr<void> enrollCourseEvent(
      DashboardEnrollCourseEvent event, Emitter<DashboardState> emit) async {
    emit(DashboardLoadingState());
    var enrollCourseResponse =
        await DashboardController().enrollCourse(event.id);
    if (enrollCourseResponse == true) {
      emit(DashboardMsgState(isError: false, msg: "Added Successfully"));
      event.dashboardBloc.add(DashboardInitialEvent());
    } else if (enrollCourseResponse is String) {
      emit(DashboardMsgState(isError: true, msg: enrollCourseResponse));
    } else {
      emit(DashboardMsgState(isError: true, msg: "Something went wrong"));
    }
  }

  FutureOr<void> dashboardContinueCourse(
      DashboardContinueCourse event, Emitter<DashboardState> emit) {
    _get.Get.to(CoursePlayerScreen(),
        transition: _get.Transition.rightToLeft,
        duration: Duration(milliseconds: 500));
  }
}
