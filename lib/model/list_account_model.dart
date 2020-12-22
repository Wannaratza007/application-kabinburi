// // To parse this JSON data, do
// //
// //     final listAccount = listAccountFromJson(jsonString);

// import 'dart:convert';

// List<ListAccount> listAccountFromJson(String str) => List<ListAccount>.from(json.decode(str).map((x) => ListAccount.fromJson(x)));

// String listAccountToJson(List<ListAccount> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class ListAccount {
//     ListAccount({
//         this.userId,
//         this.deparmentId,
//         this.firstname,
//         this.lastname,
//         this.username,
//         this.password,
//         this.status,
//         this.createDate,
//         this.deparment,
//         this.deparmentName,
//     });

//     int userId;
//     int deparmentId;
//     String firstname;
//     String lastname;
//     String username;
//     String password;
//     String status;
//     DateTime createDate;
//     int deparment;
//     String deparmentName;

//     factory ListAccount.fromJson(Map<String, dynamic> json) => ListAccount(
//         userId: json["userID"],
//         deparmentId: json["deparmentID"],
//         firstname: json["firstname"],
//         lastname: json["lastname"],
//         username: json["username"],
//         password: json["password"],
//         status: json["status"],
//         createDate: DateTime.parse(json["create_date"]),
//         deparment: json["deparment"],
//         deparmentName: json["deparment_name"],
//     );

//     Map<String, dynamic> toJson() => {
//         "userID": userId,
//         "deparmentID": deparmentId,
//         "firstname": firstname,
//         "lastname": lastname,
//         "username": username,
//         "password": password,
//         "status": status,
//         "create_date": createDate.toIso8601String(),
//         "deparment": deparment,
//         "deparment_name": deparmentName,
//     };
// }
