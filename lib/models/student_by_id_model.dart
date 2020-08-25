class DataStudentByID {
  int studenID;
  String deparmentID;
  String codesSTD;
  String prefixSTD;
  String firstNameSTD;
  String lastNameSTD;
  String phonesSTD;
  String cardNumber;
  String deparment;
  String studygroup;
  String prefixGD;
  String firstNameGD;
  String lastNameGD;
  String phonesGD;
  String numberHomes;
  String village;
  String road;
  String province;
  String aumphuer;
  String district;
  String post;
  IsActive isActive;
  int visitID;
  int studentID;
  String imagesOne;
  String imagesTwo;
  String imagesThree;
  String imageMap;
  String signture;
  String behaviorD;
  String behaviorNotD;
  String problem;
  String suggestion;
  String timeVisit;
  String visitBy;

  DataStudentByID(
      {this.studenID,
      this.deparmentID,
      this.codesSTD,
      this.prefixSTD,
      this.firstNameSTD,
      this.lastNameSTD,
      this.phonesSTD,
      this.cardNumber,
      this.deparment,
      this.studygroup,
      this.prefixGD,
      this.firstNameGD,
      this.lastNameGD,
      this.phonesGD,
      this.numberHomes,
      this.village,
      this.road,
      this.province,
      this.aumphuer,
      this.district,
      this.post,
      this.isActive,
      this.visitID,
      this.studentID,
      this.imagesOne,
      this.imagesTwo,
      this.imagesThree,
      this.imageMap,
      this.signture,
      this.behaviorD,
      this.behaviorNotD,
      this.problem,
      this.suggestion,
      this.timeVisit,
      this.visitBy});

  DataStudentByID.fromJson(Map<String, dynamic> json) {
    studenID = json['studenID'];
    deparmentID = json['deparmentID'];
    codesSTD = json['codesSTD'];
    prefixSTD = json['prefixSTD'];
    firstNameSTD = json['firstNameSTD'];
    lastNameSTD = json['lastNameSTD'];
    phonesSTD = json['phonesSTD'];
    cardNumber = json['cardNumber'];
    deparment = json['deparment'];
    studygroup = json['studygroup'];
    prefixGD = json['prefixGD'];
    firstNameGD = json['firstNameGD'];
    lastNameGD = json['lastNameGD'];
    phonesGD = json['phonesGD'];
    numberHomes = json['numberHomes'];
    village = json['village'];
    road = json['road'];
    province = json['province'];
    aumphuer = json['aumphuer'];
    district = json['district'];
    post = json['post'];
    isActive = json['is_active'] != null
        ? new IsActive.fromJson(json['is_active'])
        : null;
    visitID = json['VisitID'];
    studentID = json['StudentID'];
    imagesOne = json['ImagesOne'];
    imagesTwo = json['ImagesTwo'];
    imagesThree = json['ImagesThree'];
    imageMap = json['image_map'];
    signture = json['Signture'];
    behaviorD = json['behaviorD'];
    behaviorNotD = json['behaviorNotD'];
    problem = json['problem'];
    suggestion = json['suggestion'];
    timeVisit = json['TimeVisit'];
    visitBy = json['visit_By'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['studenID'] = this.studenID;
    data['deparmentID'] = this.deparmentID;
    data['codesSTD'] = this.codesSTD;
    data['prefixSTD'] = this.prefixSTD;
    data['firstNameSTD'] = this.firstNameSTD;
    data['lastNameSTD'] = this.lastNameSTD;
    data['phonesSTD'] = this.phonesSTD;
    data['cardNumber'] = this.cardNumber;
    data['deparment'] = this.deparment;
    data['studygroup'] = this.studygroup;
    data['prefixGD'] = this.prefixGD;
    data['firstNameGD'] = this.firstNameGD;
    data['lastNameGD'] = this.lastNameGD;
    data['phonesGD'] = this.phonesGD;
    data['numberHomes'] = this.numberHomes;
    data['village'] = this.village;
    data['road'] = this.road;
    data['province'] = this.province;
    data['aumphuer'] = this.aumphuer;
    data['district'] = this.district;
    data['post'] = this.post;
    if (this.isActive != null) {
      data['is_active'] = this.isActive.toJson();
    }
    data['VisitID'] = this.visitID;
    data['StudentID'] = this.studentID;
    data['ImagesOne'] = this.imagesOne;
    data['ImagesTwo'] = this.imagesTwo;
    data['ImagesThree'] = this.imagesThree;
    data['image_map'] = this.imageMap;
    data['Signture'] = this.signture;
    data['behaviorD'] = this.behaviorD;
    data['behaviorNotD'] = this.behaviorNotD;
    data['problem'] = this.problem;
    data['suggestion'] = this.suggestion;
    data['TimeVisit'] = this.timeVisit;
    data['visit_By'] = this.visitBy;
    return data;
  }
}

class IsActive {
  String type;
  List<int> data;

  IsActive({this.type, this.data});

  IsActive.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    data = json['data'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['data'] = this.data;
    return data;
  }
}
