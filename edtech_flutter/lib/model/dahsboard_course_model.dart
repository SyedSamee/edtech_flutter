import 'dart:convert';

import 'package:flutter/foundation.dart';

List<DashboardCourseModel> dashboardCourseModelFromjson(String str) =>
    List<DashboardCourseModel>.from(
        json.decode(str).map((x) => DashboardCourseModel.fromJson(x)));

class DashboardCourseModel {
  String name;
  String id;
  // String img;

  DashboardCourseModel({required this.name, required this.id});

  factory DashboardCourseModel.fromJson(Map<String, dynamic> json) =>
      DashboardCourseModel(name: json["name"], id: json["course_id"]);

  Map<String, dynamic> toJson() => {"name": name};
}
