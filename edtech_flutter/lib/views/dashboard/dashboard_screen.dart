import 'package:edtech_flutter/config/global.dart';
import 'package:edtech_flutter/config/utils.dart';
import 'package:edtech_flutter/controllers/dashboard_controller/dashboard_controller.dart';
import 'package:edtech_flutter/views/dashboard/bloc/dashboard_bloc.dart';
import 'package:edtech_flutter/views/dashboard/widget/dashboard_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DashboardBloc dashboardBloc = DashboardBloc();
  @override
  void initState() {
    dashboardBloc.add(DashboardInitialEvent());
    DashboardController().getAllCourses();
    listenFirebaseUser(context);
    super.initState();
  }

  @override
  void dispose() {
    dashboardBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: screenHeight * .1,
            ),
            BlocConsumer<DashboardBloc, DashboardState>(
              bloc: dashboardBloc,
              buildWhen: (previous, current) =>
                  current is DashboardLoadingState ||
                  current is DashboardInitialState,
              listenWhen: (previous, current) => current is DashboardMsgState,
              listener: (context, state) {
                state as DashboardMsgState;
                Utils().defualtMessenger(context, state.msg, state.isError);
              },
              builder: (context, state) {
                switch (state.runtimeType) {
                  case DashboardLoadingState:
                    {
                      return Center(child: Utils().defualtLoadingIndicator());
                    }

                  case DashboardInitialState:
                    {
                      state as DashboardInitialState;
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Explore Courses",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: screenHeight * .36,
                            child: state.allCourses.length == 0
                                ? Text(
                                    "No Course Found",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                : ListView.builder(
                                    itemCount: state.allCourses.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return DashboardCard(
                                        screenHeight: screenHeight,
                                        screenWidth: screenWidth,
                                        isEnroll: true,
                                        name: state.allCourses[index].name,
                                        thumbnail:
                                            state.allCourses[index].thumbnail,
                                        onTap: () {
                                          dashboardBloc.add(
                                              DashboardEnrollCourseEvent(
                                                  dashboardBloc: dashboardBloc,
                                                  id: state
                                                      .allCourses[index].id));
                                        },
                                      );
                                    }),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Enrolled Courses",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: screenHeight * .35,
                            child: state.enrolledCourses.length == 0
                                ? Text(
                                    "No Course Found",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                : ListView.builder(
                                    itemCount: state.enrolledCourses.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return DashboardCard(
                                        screenHeight: screenHeight,
                                        screenWidth: screenWidth,
                                        isEnroll: false,
                                        name: state.enrolledCourses[index].name,
                                        thumbnail: state
                                            .enrolledCourses[index].thumbnail,
                                        onTap: () {
                                          dashboardBloc.add(
                                              DashboardContinueCourse(
                                                  docId: state
                                                      .enrolledCourses[index]
                                                      .docId!,
                                                  videoUrl:
                                                      state
                                                          .enrolledCourses[
                                                              index]
                                                          .video_url,
                                                  name: state
                                                      .enrolledCourses[index]
                                                      .name));
                                        },
                                      );
                                    }),
                          ),
                        ],
                      );
                    }
                  default:
                    {
                      return SizedBox();
                    }
                }
              },
            ),
          ],
        ),
      )),
    );
  }
}
