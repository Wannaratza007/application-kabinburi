class Teacher {
  int teacherID;
  String deparment;
  String firstname;
  String lastname;
  String phone;

  Teacher(
      {this.teacherID,
      this.deparment,
      this.firstname,
      this.lastname,
      this.phone});

  Teacher.fromJson(Map<String, dynamic> json) {
    teacherID = json['teacherID'];
    deparment = json['deparment'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['teacherID'] = this.teacherID;
    data['deparment'] = this.deparment;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['phone'] = this.phone;
    return data;
  }
}
