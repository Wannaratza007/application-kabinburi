class MessagesModel {
  int messagesID;
  String urlImages;
  String link;
  String createData;
  String createBy;

  MessagesModel(
      {this.messagesID,
      this.urlImages,
      this.link,
      this.createData,
      this.createBy});

  MessagesModel.fromJson(Map<String, dynamic> json) {
    messagesID = json['messagesID'];
    urlImages = json['urlImages'];
    link = json['link'];
    createData = json['create_Data'];
    createBy = json['create_By'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['messagesID'] = this.messagesID;
    data['urlImages'] = this.urlImages;
    data['link'] = this.link;
    data['create_Data'] = this.createData;
    data['create_By'] = this.createBy;
    return data;
  }
}
