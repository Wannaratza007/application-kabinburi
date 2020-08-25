class ImagesSlider {
  int id;
  String linkImages;

  ImagesSlider({this.id, this.linkImages});

  ImagesSlider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    linkImages = json['linkImages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['linkImages'] = this.linkImages;
    return data;
  }
}
