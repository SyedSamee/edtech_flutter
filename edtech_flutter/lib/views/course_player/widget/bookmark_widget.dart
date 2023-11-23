import 'package:edtech_flutter/config/utils.dart';
import 'package:edtech_flutter/views/course_player/bloc/course_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookmarkWidget extends StatelessWidget {
  const BookmarkWidget(
      {super.key,
      required this.screenWidth,
      required this.screenHeight,
      required this.coursePlayerBloc});

  final double screenWidth;
  final double screenHeight;
  final CoursePlayerBloc coursePlayerBloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * .85,
      height: screenHeight * .4,
      decoration: BoxDecoration(
        color: Utils().secColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(children: [
        SizedBox(
          height: screenHeight * .02,
        ),
        Text(
          "Bookmarks",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: screenHeight * .04,
        ),
        BlocBuilder<CoursePlayerBloc, CoursePlayerState>(
          bloc: coursePlayerBloc,
          buildWhen: (previous, current) =>
              current is CoursePlayerBookmarkState ||
              current is CoursePlayerInitial,
          builder: (context, state) {
            switch (state.runtimeType) {
              case CoursePlayerBookmarkState:
                {
                  state as CoursePlayerBookmarkState;
                  return Container(
                      width: screenWidth * .85,
                      height: screenHeight * .25,
                      alignment: Alignment.center,
                      child: state.bookmarks.length == 0
                          ? Text("No Booksmarks Found")
                          : ListView.builder(
                              itemCount: state.bookmarks.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Center(
                                      child: Text(
                                    state.bookmarks[index],
                                  )),
                                );
                              }));
                }

              default:
                {
                  return Utils().defualtLoadingIndicator();
                }
            }
          },
        )
      ]),
    );
  }
}
