// To parse this JSON data, do
//
//     final studentId = studentIdFromJson(jsonString);

import 'dart:convert';

List<StudentId> studentIdFromJson(String str) =>
    List<StudentId>.from(json.decode(str).map((x) => StudentId.fromJson(x)));

String studentIdToJson(List<StudentId> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StudentId {
  StudentId({
    this.student,
    this.deparmentId,
    this.codeStd,
    this.prefixStd,
    this.firstnameStd,
    this.lastnameStd,
    this.phonesStd,
    this.cardNumber,
    this.studygroup,
    this.prefixGd,
    this.firstnameGd,
    this.lastnameGd,
    this.phonesGd,
    this.numberHomes,
    this.village,
    this.road,
    this.province,
    this.aumphuer,
    this.district,
    this.post,
    this.isActive,
    this.isVisit,
    this.deparment,
    this.deparmentName,
    this.visit,
    this.studentId,
    this.imageVisit,
    this.imageMap,
    this.signture,
    this.behaviorD,
    this.behaviorNotD,
    this.problem,
    this.suggestion,
    this.nameParents,
    this.dateVisit,
    this.visitBy,
  });

  int student;
  String deparmentId;
  String codeStd;
  String prefixStd;
  String firstnameStd;
  String lastnameStd;
  dynamic phonesStd;
  String cardNumber;
  String studygroup;
  String prefixGd;
  String firstnameGd;
  String lastnameGd;
  String phonesGd;
  String numberHomes;
  String village;
  String road;
  String province;
  String aumphuer;
  String district;
  String post;
  int isActive;
  int isVisit;
  int deparment;
  String deparmentName;
  int visit;
  String studentId;
  String imageVisit;
  String imageMap;
  dynamic signture;
  String behaviorD;
  String behaviorNotD;
  String problem;
  dynamic suggestion;
  String nameParents;
  DateTime dateVisit;
  String visitBy;

  factory StudentId.fromJson(Map<String, dynamic> json) => StudentId(
        student: json["student"],
        deparmentId: json["deparmentID"],
        codeStd: json["codeSTD"],
        prefixStd: json["prefixSTD"],
        firstnameStd: json["firstnameSTD"],
        lastnameStd: json["lastnameSTD"],
        phonesStd: json["phonesSTD"],
        cardNumber: json["cardNumber"],
        studygroup: json["studygroup"],
        prefixGd: json["prefixGD"],
        firstnameGd: json["firstnameGD"],
        lastnameGd: json["lastnameGD"],
        phonesGd: json["phonesGD"],
        numberHomes: json["numberHomes"],
        village: json["village"],
        road: json["road"],
        province: json["province"],
        aumphuer: json["aumphuer"],
        district: json["district"],
        post: json["post"],
        isActive: json["is_active"],
        isVisit: json["is_visit"],
        deparment: json["deparment"],
        deparmentName: json["deparment_name"],
        visit: json["visit"],
        studentId: json["studentID"],
        imageVisit: json["image_visit"],
        imageMap: json["image_map"],
        signture: json["signture"],
        behaviorD: json["behaviorD"],
        behaviorNotD: json["behaviorNotD"],
        problem: json["problem"],
        suggestion: json["suggestion"],
        nameParents: json["name_parents"],
        dateVisit: DateTime.parse(json["date_visit"]),
        visitBy: json["visit_by"],
      );

  Map<String, dynamic> toJson() => {
        "student": student,
        "deparmentID": deparmentId,
        "codeSTD": codeStd,
        "prefixSTD": prefixStd,
        "firstnameSTD": firstnameStd,
        "lastnameSTD": lastnameStd,
        "phonesSTD": phonesStd,
        "cardNumber": cardNumber,
        "studygroup": studygroup,
        "prefixGD": prefixGd,
        "firstnameGD": firstnameGd,
        "lastnameGD": lastnameGd,
        "phonesGD": phonesGd,
        "numberHomes": numberHomes,
        "village": village,
        "road": road,
        "province": province,
        "aumphuer": aumphuer,
        "district": district,
        "post": post,
        "is_active": isActive,
        "is_visit": isVisit,
        "deparment": deparment,
        "deparment_name": deparmentName,
        "visit": visit,
        "studentID": studentId,
        "image_visit": imageVisit,
        "image_map": imageMap,
        "signture": signture,
        "behaviorD": behaviorD,
        "behaviorNotD": behaviorNotD,
        "problem": problem,
        "suggestion": suggestion,
        "name_parents": nameParents,
        "date_visit": dateVisit.toIso8601String(),
        "visit_by": visitBy,
      };
}
  