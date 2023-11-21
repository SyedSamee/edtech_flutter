import 'package:edtech_flutter/config/global.dart';
import 'package:edtech_flutter/config/utils.dart';
import 'package:edtech_flutter/views/course_player/widget/bookmark_widget.dart';
import 'package:edtech_flutter/views/course_player/widget/title_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CoursePlayerScreen extends StatefulWidget {
  const CoursePlayerScreen({super.key});

  @override
  State<CoursePlayerScreen> createState() => _CoursePlayerScreenState();
}

class _CoursePlayerScreenState extends State<CoursePlayerScreen> {
  @override
  void initState() {
    listenFirebaseUser(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: screenHeight * .04,
              ),
              TitleWidget(screenWidth: screenWidth, screenHeight: screenHeight),
              SizedBox(
                height: screenHeight * .04,
              ),
              BookmarkWidget(
                  screenWidth: screenWidth, screenHeight: screenHeight)
            ],
          ),
        ),
      )),
    );
  }
}
