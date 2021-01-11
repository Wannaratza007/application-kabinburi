// To parse this JSON data, do
//
//     final student = studentFromJson(jsonString);

import 'dart:convert';

List<Student> studentFromJson(String str) => List<Student>.from(json.decode(str).map((x) => Student.fromJson(x)));

String studentToJson(List<Student> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Student {
    Student({
        this.student,
        this.deparmentId,
        this.deparmentName,
        this.prefixStd,
        this.firstnameStd,
        this.lastnameStd,
        this.phonesStd,
        this.studygroup,
        this.prefixGd,
        this.firstnameGd,
        this.lastnameGd,
        this.phonesGd,
        this.numberHomes,
        this.alley,
        this.village,
        this.road,
        this.province,
        this.aumphuer,
        this.district,
        this.isVisit,
        this.longitude,
        this.latitude,
        this.visit,
        this.imageMap,
        this.imageVisit,
        this.behaviorD,
        this.behaviorNotD,
        this.signture,
        this.problem,
        this.suggestion,
        this.nameParents,
        this.visitBy,
        this.anotherRelevanceParents,
        this.anotherLivingStatus,
        this.anotherCharacteristicsAddress,
        this.anotherComeToSchoolBy,
        this.relevanceParents,
        this.livingStatus,
        this.characteristicsAddress,
        this.comeToSchoolBy,
    });

    int student;
    String deparmentId;
    String deparmentName;
    String prefixStd;
    String firstnameStd;
    String lastnameStd;
    String phonesStd;
    String studygroup;
    String prefixGd;
    String firstnameGd;
    String lastnameGd;
    String phonesGd;
    String numberHomes;
    dynamic alley;
    String village;
    dynamic road;
    String province;
    String aumphuer;
    String district;
    int isVisit;
    dynamic longitude;
    dynamic latitude;
    int visit;
    String imageMap;
    String imageVisit;
    String behaviorD;
    String behaviorNotD;
    String signture;
    String problem;
    String suggestion;
    String nameParents;
    String visitBy;
    String anotherRelevanceParents;
    String anotherLivingStatus;
    String anotherCharacteristicsAddress;
    String anotherComeToSchoolBy;
    String relevanceParents;
    String livingStatus;
    String characteristicsAddress;
    String comeToSchoolBy;

    factory Student.fromJson(Map<String, dynamic> json) => Student(
        student: json["student"],
        deparmentId: json["deparmentID"],
        deparmentName: json["deparment_name"],
        prefixStd: json["prefixSTD"],
        firstnameStd: json["firstnameSTD"],
        lastnameStd: json["lastnameSTD"],
        phonesStd: json["phonesSTD"],
        studygroup: json["studygroup"],
        prefixGd: json["prefixGD"],
        firstnameGd: json["firstnameGD"],
        lastnameGd: json["lastnameGD"],
        phonesGd: json["phonesGD"],
        numberHomes: json["numberHomes"],
        alley: json["alley"],
        village: json["village"],
        road: json["road"],
        province: json["province"],
        aumphuer: json["aumphuer"],
        district: json["district"],
        isVisit: json["is_visit"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        visit: json["visit"],
        imageMap: json["image_map"],
        imageVisit: json["image_visit"],
        behaviorD: json["behaviorD"],
        behaviorNotD: json["behaviorNotD"],
        signture: json["signture"],
        problem: json["problem"],
        suggestion: json["suggestion"],
        nameParents: json["name_parents"],
        visitBy: json["visit_by"],
        anotherRelevanceParents: json["anotherRelevanceParents"],
        anotherLivingStatus: json["anotherLivingStatus"],
        anotherCharacteristicsAddress: json["anotherCharacteristicsAddress"],
        anotherComeToSchoolBy: json["anotherComeToSchoolBy"],
        relevanceParents: json["relevanceParents"],
        livingStatus: json["livingStatus"],
        characteristicsAddress: json["characteristicsAddress"],
        comeToSchoolBy: json["comeToSchoolBy"],
    );

    Map<String, dynamic> toJson() => {
        "student": student,
        "deparmentID": deparmentId,
        "deparment_name": deparmentName,
        "prefixSTD": prefixStd,
        "firstnameSTD": firstnameStd,
        "lastnameSTD": lastnameStd,
        "phonesSTD": phonesStd,
        "studygroup": studygroup,
        "prefixGD": prefixGd,
        "firstnameGD": firstnameGd,
        "lastnameGD": lastnameGd,
        "phonesGD": phonesGd,
        "numberHomes": numberHomes,
        "alley": alley,
        "village": village,
        "road": road,
        "province": province,
        "aumphuer": aumphuer,
        "district": district,
        "is_visit": isVisit,
        "longitude": longitude,
        "latitude": latitude,
        "visit": visit,
        "image_map": imageMap,
        "image_visit": imageVisit,
        "behaviorD": behaviorD,
        "behaviorNotD": behaviorNotD,
        "signture": signture,
        "problem": problem,
        "suggestion": suggestion,
        "name_parents": nameParents,
        "visit_by": visitBy,
        "anotherRelevanceParents": anotherRelevanceParents,
        "anotherLivingStatus": anotherLivingStatus,
        "anotherCharacteristicsAddress": anotherCharacteristicsAddress,
        "anotherComeToSchoolBy": anotherComeToSchoolBy,
        "relevanceParents": relevanceParents,
        "livingStatus": livingStatus,
        "characteristicsAddress": characteristicsAddress,
        "comeToSchoolBy": comeToSchoolBy,
    };
}
