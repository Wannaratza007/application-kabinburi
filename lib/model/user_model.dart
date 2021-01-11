// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User({
    this.userId,
    this.deparmentId,
    this.prefix,
    this.firstname,
    this.lastname,
    this.username,
    this.password,
    this.status,
    this.deparment,
    this.deparmentName,
  });

  int userId;
  int deparmentId;
  String prefix;
  String firstname;
  String lastname;
  String username;
  String password;
  String status;
  int deparment;
  String deparmentName;

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["userID"],
        deparmentId: json["deparmentID"],
        prefix: json["prefix"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        username: json["username"],
        password: json["password"],
        status: json["status"],
        deparment: json["deparment"],
        deparmentName: json["deparment_name"],
      );

  Map<String, dynamic> toJson() => {
        "userID": userId,
        "deparmentID": deparmentId,
        "prefix": prefix,
        "firstname": firstname,
        "lastname": lastname,
        "username": username,
        "password": password,
        "status": status,
        "deparment": deparment,
        "deparment_name": deparmentName,
      };
}
