import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoursePlayerController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future bookmarkDuration(String docId, String bookmark) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List enrolledCourseBookMark = [];
    try {
      //for getting the previous book mark list
      var enrolledCourseData = await firestore
          .collection("users")
          .doc(sharedPreferences.getString("userId"))
          .collection("enrolled_courses")
          .doc(docId)
          .get();
      enrolledCourseBookMark = enrolledCourseData.data()?["bookmarks"] == null
          ? []
          : enrolledCourseData.data()?["bookmarks"];
      enrolledCourseBookMark.add(bookmark);
      await firestore
          .collection("users")
          .doc(sharedPreferences.getString("userId"))
          .collection("enrolled_courses")
          .doc(docId)
          .set(
              {"bookmarks": enrolledCourseBookMark},
              SetOptions(
                merge: true,
              ));

      return true;
    } catch (e) {
      return e is FirebaseException ? e.message : e;
    }
  }

  Future GetAllBookmarks(String docId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List booksmarks = [];
    try {
      var enrolledCourseData = await firestore
          .collection("users")
          .doc(sharedPreferences.getString("userId"))
          .collection("enrolled_courses")
          .doc(docId)
          .get();
      if (enrolledCourseData.exists) {
        booksmarks = enrolledCourseData.data()?["bookmarks"] == null
            ? []
            : enrolledCourseData.data()!["bookmarks"] as List;
        return booksmarks;
      } else {
        return "Something went wrong";
      }
    } catch (e) {
      return e is FirebaseException ? e.message : e;
    }
  }
}
