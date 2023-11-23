import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edtech_flutter/model/dashboard/dahsboard_course_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future getAllCourses() async {
    List<DashboardCourseModel> allCourses = [];
    List allCourseId = [];
    List allEnrolledCourseId = [];
    Map<String, dynamic> course = {};
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //getting all courses from the data base
    try {
      var courseResponse =
          await firebaseFirestore.collection("all_courses").get();
      var enrolledCourseResponse = await firebaseFirestore
          .collection("users")
          .doc(sharedPreferences.getString("userId"))
          .collection("enrolled_courses")
          .get();
      if (courseResponse.docs.isNotEmpty) {
        //for getting all the id
        for (var e = 0; e < courseResponse.size; e++) {
          allCourseId.add(courseResponse.docs[e].id);
        }
        for (var f = 0; f < enrolledCourseResponse.size; f++) {
          allEnrolledCourseId
              .add(enrolledCourseResponse.docs[f].data()["course_id"]);
        }

        // for checking check if user enroll in any course if yes do not add it in all courses list

        for (var w = 0; w < courseResponse.size; w++) {
          if (enrolledCourseResponse.docs.isNotEmpty) {
            if (allEnrolledCourseId.contains(allCourseId[w]) == false) {
              course = courseResponse.docs[w].data();
              //adding with the id
              course.addAll({"course_id": courseResponse.docs[w].id});

              allCourses.add(DashboardCourseModel.fromJson(course));
            }
          } else {
            course = courseResponse.docs[w].data();
            //adding with the id
            course.addAll({"course_id": courseResponse.docs[w].id});

            allCourses.add(DashboardCourseModel.fromJson(course));
          }
        }

        return allCourses;
      }
    } catch (e) {
      return e is FirebaseException ? e.message : e;
    }
  }

  Future getEnrolledCourses() async {
    List enrolledCoursesIds = [];
    List enrolledCourseDocId = [];
    List<DashboardCourseModel> enrolledCourses = [];
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map<String, dynamic> course = {};
    try {
      var enrolledCoursesResponse = await firebaseFirestore
          .collection("users")
          .doc(sharedPreferences.getString("userId"))
          .collection("enrolled_courses")
          .get();
      if (enrolledCoursesResponse.docs.isNotEmpty) {
        //adding all courses to all course list
        for (var e = 0; e < enrolledCoursesResponse.size; e++) {
          //this enroll doc id will be used for adding course book mark in to the same doc that is why we have added it
          enrolledCourseDocId.add(enrolledCoursesResponse.docs[e].id);
          enrolledCoursesIds
              .add(enrolledCoursesResponse.docs[e].data()["course_id"]);
        }
        // getting all courses from the enrolled id
        for (var w = 0; w < enrolledCoursesIds.length; w++) {
          var courseResponse = await firebaseFirestore
              .collection("all_courses")
              .doc(enrolledCoursesIds[w])
              .get();
          // adding all the enrolled courses to course list
          course = courseResponse.data() == null ? {} : courseResponse.data()!;
          //adding with the course id and doc id
          //doc id is required to send bookmark detail to add bookmarks into enroll collectio
          course.addAll({
            "course_id": enrolledCoursesIds[w],
            "doc_id": enrolledCourseDocId[w]
          });

          enrolledCourses.add(DashboardCourseModel.fromJson(course));
        }

        return enrolledCourses;
      } else {
        return enrolledCourses;
      }
    } catch (e) {
      return e is FirebaseException ? e.message : e;
    }
  }

  Future enrollCourse(String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var enrolledCoursesResponse = await firebaseFirestore
        .collection("users")
        .doc(sharedPreferences.getString("userId"))
        .collection("enrolled_courses")
        .add({"course_id": id});
    if (enrolledCoursesResponse.id != null) {
      return true;
    } else {
      return "Something went wrong";
    }
  }
}
