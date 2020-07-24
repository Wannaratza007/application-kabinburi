class AddNewData {
  bool status;
  List<int> id;

  AddNewData({this.status, this.id});

  AddNewData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    id = json['id'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['id'] = this.id;
    return data;
  }
}
