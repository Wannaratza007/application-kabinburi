class CommunityModel {
  int communityID;
  String urlimages;
  String link;
  String title;
  String createDate;

  CommunityModel(
      {this.communityID,
      this.urlimages,
      this.link,
      this.title,
      this.createDate});

  CommunityModel.fromJson(Map<String, dynamic> json) {
    communityID = json['communityID'];
    urlimages = json['urlimages'];
    link = json['link'];
    title = json['title'];
    createDate = json['Create_Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['communityID'] = this.communityID;
    data['urlimages'] = this.urlimages;
    data['link'] = this.link;
    data['title'] = this.title;
    data['Create_Date'] = this.createDate;
    return data;
  }
}
