import 'dart:convert';

import 'package:flutter/foundation.dart';

List<DashboardCourseModel> dashboardCourseModelFromjson(String str) =>
    List<DashboardCourseModel>.from(
        json.decode(str).map((x) => DashboardCourseModel.fromJson(x)));

class DashboardCourseModel {
  String name;
  String id;
  String docId;
  // String img;

  DashboardCourseModel(
      {required this.name, required this.id, required this.docId});

  factory DashboardCourseModel.fromJson(Map<String, dynamic> json) =>
      DashboardCourseModel(
          name: json["name"], id: json["course_id"], docId: json["doc_id"]);

  Map<String, dynamic> toJson() => {"name": name};
}
