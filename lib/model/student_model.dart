// To parse this JSON data, do
//
//     final student = studentFromJson(jsonString);

import 'dart:convert';

List<Student> studentFromJson(String str) =>
    List<Student>.from(json.decode(str).map((x) => Student.fromJson(x)));

String studentToJson(List<Student> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Student {
  Student({
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
  });

  int student;
  String deparmentId;
  String codeStd;
  String prefixStd;
  String firstnameStd;
  String lastnameStd;
  String phonesStd;
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

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        student: json["student"],
        deparmentId: json["deparmentID"],
        codeStd: json["codeSTD"],
        prefixStd: json["prefixSTD"],
        firstnameStd: json["firstnameSTD"],
        lastnameStd: json["lastnameSTD"],
        phonesStd: json["phonesSTD"] == null ? null : json["phonesSTD"],
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
      );

  Map<String, dynamic> toJson() => {
        "student": student,
        "deparmentID": deparmentId,
        "codeSTD": codeStd,
        "prefixSTD": prefixStd,
        "firstnameSTD": firstnameStd,
        "lastnameSTD": lastnameStd,
        "phonesSTD": phonesStd == null ? null : phonesStd,
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
      };
}

// // To parse this JSON data, do
// //
// //     final student = studentFromJson(jsonString);

// import 'dart:convert';

// List<Student> studentFromJson(String str) =>
//     List<Student>.from(json.decode(str).map((x) => Student.fromJson(x)));

// String studentToJson(List<Student> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class Student {
//   Student({
//     this.student,
//     this.deparmentId,
//     this.codeStd,
//     this.prefixStd,
//     this.firstnameStd,
//     this.lastnameStd,
//     this.phonesStd,
//     this.cardNumber,
//     this.studygroup,
//     this.prefixGd,
//     this.firstnameGd,
//     this.lastnameGd,
//     this.phonesGd,
//     this.numberHomes,
//     this.village,
//     this.road,
//     this.province,
//     this.aumphuer,
//     this.district,
//     this.post,
//     this.isActive,
//     this.isVisit,
//     this.deparment,
//     this.deparmentName,
//   });

//   int student;
//   String deparmentId;
//   String codeStd;
//   String prefixStd;
//   String firstnameStd;
//   String lastnameStd;
//   String phonesStd;
//   String cardNumber;
//   String studygroup;
//   String prefixGd;
//   String firstnameGd;
//   String lastnameGd;
//   String phonesGd;
//   String numberHomes;
//   String village;
//   String road;
//   String province;
//   String aumphuer;
//   String district;
//   String post;
//   Is isActive;
//   Is isVisit;
//   int deparment;
//   String deparmentName;

//   factory Student.fromJson(Map<String, dynamic> json) => Student(
//         student: json["student"],
//         deparmentId: json["deparmentID"],
//         codeStd: json["codeSTD"],
//         prefixStd: json["prefixSTD"],
//         firstnameStd: json["firstnameSTD"],
//         lastnameStd: json["lastnameSTD"],
//         phonesStd: json["phonesSTD"] == null ? null : json["phonesSTD"],
//         cardNumber: json["cardNumber"],
//         studygroup: json["studygroup"] == null ? null : json["studygroup"],
//         prefixGd: json["prefixGD"],
//         firstnameGd: json["firstnameGD"],
//         lastnameGd: json["lastnameGD"],
//         phonesGd: json["phonesGD"],
//         numberHomes: json["numberHomes"],
//         village: json["village"],
//         road: json["road"],
//         province: json["province"] == null ? null : json["province"],
//         aumphuer: json["aumphuer"] == null ? null : json["aumphuer"],
//         district: json["district"] == null ? null : json["district"],
//         post: json["post"],
//         isActive: Is.fromJson(json["is_active"]),
//         isVisit: Is.fromJson(json["is_visit"]),
//         deparment: json["deparment"],
//         deparmentName: json["deparment_name"],
//       );

//   Map<String, dynamic> toJson() => {
//         "student": student,
//         "deparmentID": deparmentId,
//         "codeSTD": codeStd,
//         "prefixSTD": prefixStd,
//         "firstnameSTD": firstnameStd,
//         "lastnameSTD": lastnameStd,
//         "phonesSTD": phonesStd == null ? null : phonesStd,
//         "cardNumber": cardNumber,
//         "studygroup": studygroup == null ? null : studygroup,
//         "prefixGD": prefixGd,
//         "firstnameGD": firstnameGd,
//         "lastnameGD": lastnameGd,
//         "phonesGD": phonesGd,
//         "numberHomes": numberHomes,
//         "village": village,
//         "road": road,
//         "province": province == null ? null : province,
//         "aumphuer": aumphuer == null ? null : aumphuer,
//         "district": district == null ? null : district,
//         "post": post,
//         "is_active": isActive.toJson(),
//         "is_visit": isVisit.toJson(),
//         "deparment": deparment,
//         "deparment_name": deparmentName,
//       };
// }

// class Is {
//   Is({
//     this.type,
//     this.data,
//   });

//   String type;
//   List<int> data;

//   factory Is.fromJson(Map<String, dynamic> json) => Is(
//         type: json["type"],
//         data: List<int>.from(json["data"].map((x) => x)),
//       );

//   Map<String, dynamic> toJson() => {
//         "type": type,
//         "data": List<dynamic>.from(data.map((x) => x)),
//       };
// }
