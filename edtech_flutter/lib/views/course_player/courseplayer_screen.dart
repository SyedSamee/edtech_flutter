import 'package:edtech_flutter/config/extention/string_extention.dart';
import 'package:edtech_flutter/config/global.dart';
import 'package:edtech_flutter/config/utils.dart';
import 'package:edtech_flutter/controllers/course_player_controller/course_player_controller.dart';

import 'package:edtech_flutter/views/course_player/bloc/course_bloc.dart';
import 'package:edtech_flutter/views/course_player/widget/bookmark_widget.dart';
import 'package:edtech_flutter/views/course_player/widget/title_widget.dart';
import 'package:edtech_flutter/views/home/bloc/home_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoursePlayerScreen extends StatefulWidget {
  final String video_url;
  final String docId;
  final String name;

  const CoursePlayerScreen(
      {super.key,
      required this.docId,
      required this.video_url,
      required this.name});

  @override
  State<CoursePlayerScreen> createState() => _CoursePlayerScreenState();
}

class _CoursePlayerScreenState extends State<CoursePlayerScreen> {
  CustomVideoPlayerController? _customvideoPlayerController;
  Duration? videoCurrentDuration;
  CoursePlayerBloc coursePlayerBloc = CoursePlayerBloc();
  bool isVideoCompleted = false;
  @override
  void initState() {
    initializeVideoPlayer();
    listenFirebaseUser(context);

    super.initState();
  }

  @override
  void dispose() {
    coursePlayerBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: BlocConsumer<CoursePlayerBloc, CoursePlayerState>(
            bloc: coursePlayerBloc,
            buildWhen: (previous, current) =>
                current is CourseVideoPlayerState ||
                current is CoursePlayerLoadingState,
            listener: (context, state) {
              state as CoursePlayerMsgState;
              Utils().defualtMessenger(context, state.msg, state.isError);
            },
            listenWhen: (previous, current) => current is CoursePlayerMsgState,
            builder: (context, state) {
              switch (state.runtimeType) {
                case CourseVideoPlayerState:
                  {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: screenHeight * .04,
                        ),
                        Column(
                          children: [
                            Container(
                              width: screenWidth * .85,
                              height: screenHeight * .3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              child: CustomVideoPlayer(
                                customVideoPlayerController:
                                    _customvideoPlayerController!,
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * .04,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 35),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.name,
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        coursePlayerBloc.add(
                                            CoursePlayerBookmarkEvent(
                                                docId: widget.docId,
                                                bookmarkDuration:
                                                    videoCurrentDuration!
                                                        .durationFormat,
                                                coursePlayerBloc:
                                                    coursePlayerBloc));
                                      },
                                      icon: Icon(
                                        Icons.bookmark_outline,
                                        size: 30,
                                        color: Colors.black,
                                      ))
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: screenHeight * .04,
                        ),
                        BookmarkWidget(
                          screenWidth: screenWidth,
                          screenHeight: screenHeight,
                          coursePlayerBloc: coursePlayerBloc,
                        )
                      ],
                    );
                  }

                case CoursePlayerLoadingState:
                  {
                    return Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Utils().defualtLoadingIndicator(),
                    );
                  }
                default:
                  {
                    return SizedBox();
                  }
              }
            },
          ),
        ),
      )),
    );
  }

  initializeVideoPlayer() async {
    VideoPlayerController videoPlayerController;
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.video_url))
          ..initialize().then((value) => {
                coursePlayerBloc.add(
                  CoursePlayerVideoEvent(
                      coursePlayerBloc: coursePlayerBloc, docId: widget.docId),
                )
              });

    videoPlayerController.addListener(() {
      videoCurrentDuration = videoPlayerController.value.position;
      if (videoPlayerController.value.duration ==
              videoPlayerController.value.position &&
          isVideoCompleted == false) {
        // show a alert box
        isVideoCompleted = true;
        showDialog(
          context: context,
          builder: (context) => GestureDetector(
            onTap: () {},
            child: WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: AlertDialog(actions: [
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                      onPressed: () {
                        coursePlayerBloc
                            .add(CoursePlayerClaimCertificateEvent());
                      },
                      child: Text("Claim Your Certificate")),
                )
              ]),
            ),
          ),
        );
      }
    });

    _customvideoPlayerController = CustomVideoPlayerController(
        context: context, videoPlayerController: videoPlayerController);

    return true;
  }
}
