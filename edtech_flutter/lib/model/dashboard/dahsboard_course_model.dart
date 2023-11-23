import 'dart:convert';

import 'package:flutter/foundation.dart';

List<DashboardCourseModel> dashboardCourseModelFromjson(String str) =>
    List<DashboardCourseModel>.from(
        json.decode(str).map((x) => DashboardCourseModel.fromJson(x)));

class DashboardCourseModel {
  String name;
  String id;
  String? docId;
  String thumbnail;
  String video_url;
  // String img;

  DashboardCourseModel(
      {required this.name,
      required this.id,
      required this.docId,
      required this.thumbnail,
      required this.video_url});

  factory DashboardCourseModel.fromJson(Map<String, dynamic> json) =>
      DashboardCourseModel(
        name: json["name"],
        docId: json["doc_id"] == null ? "" : json["doc_id"],
        thumbnail: json["thumbnail"],
        video_url: json["video_url"],
        id: json["course_id"],
      );

  // Map<String, dynamic> toJson() => {"name": name};
}
