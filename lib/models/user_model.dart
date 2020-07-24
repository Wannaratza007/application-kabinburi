class UserModel {
  int userID;
  String deparment;
  String firstname;
  String lastname;
  String username;
  String password;
  String status;
  String createDate;

  UserModel(
      {this.userID,
      this.deparment,
      this.firstname,
      this.lastname,
      this.username,
      this.password,
      this.status,
      this.createDate});

  UserModel.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    deparment = json['deparment'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    username = json['username'];
    password = json['password'];
    status = json['status'];
    createDate = json['create_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['deparment'] = this.deparment;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['username'] = this.username;
    data['password'] = this.password;
    data['status'] = this.status;
    data['create_date'] = this.createDate;
    return data;
  }
}
