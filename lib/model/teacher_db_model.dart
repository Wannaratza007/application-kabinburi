// To parse this JSON data, do
//
//     final dashboardTeacher = dashboardTeacherFromJson(jsonString);

import 'dart:convert';

List<DashboardTeacher> dashboardTeacherFromJson(String str) => List<DashboardTeacher>.from(json.decode(str).map((x) => DashboardTeacher.fromJson(x)));

String dashboardTeacherToJson(List<DashboardTeacher> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DashboardTeacher {
    DashboardTeacher({
        this.amountvisit,
        this.amountnotvisit,
    });

    int amountvisit;
    int amountnotvisit;

    factory DashboardTeacher.fromJson(Map<String, dynamic> json) => DashboardTeacher(
        amountvisit: json["amountvisit"] == null ? null : json["amountvisit"],
        amountnotvisit: json["amountnotvisit"] == null ? null : json["amountnotvisit"],
    );

    Map<String, dynamic> toJson() => {
        "amountvisit": amountvisit == null ? null : amountvisit,
        "amountnotvisit": amountnotvisit == null ? null : amountnotvisit,
    };
}
