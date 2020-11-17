import 'dart:convert';
import 'dart:io';
import 'package:KABINBURI/model/student_model.dart';
import 'package:KABINBURI/style/connect_api.dart';
import 'package:KABINBURI/style/contsan.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';

// ignore: must_be_immutable
class VisitHomePage extends StatefulWidget {
  int idStudent;
  VisitHomePage({Key key, this.idStudent}) : super(key: key);

  @override
  _VisitHomePageState createState() => _VisitHomePageState();
}

class _VisitHomePageState extends State<VisitHomePage> {
  File _imagevisit, _imageAddress;
  var students;
  var nameStd, prefixstd, firstSTD, lastSTD, deparment;
  var behaviorD = TextEditingController();
  var behaviorNotD = TextEditingController();
  var problem = TextEditingController();
  var suggestion = TextEditingController();
  var nameGD = TextEditingController();
  var nameTHVisit = TextEditingController();
  bool loadData = false;
  bool saveing = true;

  @override
  void initState() {
    super.initState();
    apiGetDataID();
  }

  Future apiGetDataID() async {
    var client = http.Client();
    var pfs = await SharedPreferences.getInstance();
    var visitBy = pfs.getString('firstname') + " " + pfs.getString('lastname');
    try {
      var _url = '$api/server/student/get-studentId';
      var _obj = {
        "id": (widget.idStudent).toString(),
      };
      var response = await client.post(_url, body: _obj);
      var res = json.decode(response.body);
      if (res["status"] == true) {
        for (var item in res["result"]) {
          students = Student.fromJson(item);
          setState(() {
            var prefixS = students.prefixStd == null ? "-" : students.prefixStd;
            var nameS =
                students.firstnameStd == null ? "-" : students.firstnameStd;
            var lastS =
                students.lastnameStd == null ? "-" : students.lastnameStd;
            var groupS =
                students.studygroup == null ? "-" : students.studygroup;
            var deparmentS =
                students.deparmentName == null ? "-" : students.deparmentName;
            nameStd = prefixS +
                ' ' +
                nameS +
                '  ' +
                lastS +
                ' ' +
                'ระดับชั้น' +
                '  ' +
                groupS;
            deparment = 'แผนกวิชา  ' + deparmentS;
            nameGD.text = students.firstnameGd + ' ' + students.lastnameGd;
            nameTHVisit.text = visitBy;
          });
        }
        setState(() {
          loadData = true;
        });
      }
      return true;
    } finally {
      client.close();
    }
  }

  Future apisaveDataVisit() async {
    var client = http.Client();
    var pfs = await SharedPreferences.getInstance();
    var visitBy = pfs.getString('firstname') + " " + pfs.getString('lastname');
    try {
      SweetAlert.show(context,
          subtitle: "Save...", style: SweetAlertStyle.loading);
      if (_imagevisit == null && _imageAddress == null) return;
      String base64Imagevisit = base64Encode(_imagevisit.readAsBytesSync());
      String fileNamevisit = _imagevisit.path.split("/").last;
      String base64ImageAddress = base64Encode(_imageAddress.readAsBytesSync());
      String fileNameAddress = _imageAddress.path.split("/").last;
      var _obj = {
        "studenID": (students.student).toString(),
        "base64Imagevisit": base64Imagevisit,
        "fileNamevisit": fileNamevisit,
        "base64ImageAddress": base64ImageAddress,
        "fileNameAddress": fileNameAddress,
        "behaviorD": behaviorD.text.trim(),
        "behaviorNotD": behaviorNotD.text.trim(),
        "problem": problem.text.trim(),
        "suggestion": suggestion.text.trim(),
        "nameGD": nameGD.text.trim(),
        "visit_By": visitBy,
      };
      var response =
          await client.post('$api/server/student/visthome-student', body: _obj);
      var data = jsonDecode(response.body);
      if (data["status"] == true) {
        new Future.delayed(new Duration(microseconds: 800), () {
          SweetAlert.show(
            context,
            subtitle: "Success!",
            style: SweetAlertStyle.success,
          );
          setState(() {
            saveing = true;
          });
        });
      } else {
        new Future.delayed(new Duration(microseconds: 800), () {
          SweetAlert.show(context,
              subtitle: data["result"], style: SweetAlertStyle.error);
          setState(() {
            saveing = true;
          });
        });
      }
    } finally {
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        // actions: [
        //   Container(
        //     margin: EdgeInsets.only(right: 10.0),
        //     child: IconButton(
        //       icon: Icon(Icons.edit),
        //       onPressed: () => Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => Signture(),
        //         ),
        //       ),
        //     ),
        //   ),
        // ],
      ),
      body: loadData == false
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [progress()],
              ),
            )
          : Container(
              padding: EdgeInsets.all(5.0),
              child: Card(
                elevation: 5.0,
                child: ListView(children: <Widget>[
                  SizedBox(height: 15.0),
                  titleSub('ข้อมูลนักศึกษา'),
                  SizedBox(height: 15.0),
                  showDatas(nameStd),
                  showDatas(deparment),
                  border(),
                  titleSub('รูปภาพการเยี่ยมบ้าน'),
                  SizedBox(height: 15.0),
                  buildpickimagevisit(context),
                  SizedBox(height: 15.0),
                  titleSub('รูปภาพการเยี่ยมบ้าน'),
                  SizedBox(height: 15.0),
                  buildpickimageAddress(context),
                  SizedBox(height: 15.0),
                  titleSub('พฤติกรรมของนักศึกษา'),
                  inputcomment(behaviorD, 'พฤติกรรม ด้านดี'),
                  inputcomment(behaviorNotD, 'พฤติกรรม ที่ต้องปรับหรุง'),
                  SizedBox(height: 15.0),
                  titleSub('ปัญหาของนักศึกษา'),
                  inputcomment(problem, 'พฤติกรรม ด้านดี'),
                  SizedBox(height: 15.0),
                  titleSub('ข้อเสนอแนะ'),
                  inputcomment(suggestion, 'อื่นๆ...'),
                  SizedBox(height: 15.0),
                  titleSub('ลงชื่อผู้ปกครอง'),
                  inputcomment(nameGD, 'ชื่อผู้ปกครอง'),
                  SizedBox(height: 15.0),
                  titleSub('ลงชื่อครูผู้ไปเยี่ยม'),
                  showcomment(nameTHVisit, 'ลงชื่อครูผู้ไปเยี่ยม', false),
                  buttonSVAE(),
                  SizedBox(height: 15.0),
                ]),
              ),
            ),
    );
  }

  Widget buttonSVAE() {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(8.0),
      height: 65.0,
      child: RaisedButton(
        child: Text(
          'SVAE',
          style: TextStyle(
            fontSize: 24.0,
          ),
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        textColor: Colors.white,
        color: Colors.blue,
        onPressed: () {
          saveing == false
              ? EdgeAlert.show(context,
                  title: 'กำลังบันทึกข้อมูล',
                  description: 'กรุณารอสักครู่ค่ะ...',
                  gravity: EdgeAlert.TOP,
                  backgroundColor: Colors.blue,
                  icon: Icons.check_circle_outline)
              : SweetAlert.show(context,
                  subtitle: "คุณต้องการบันทึกข้อมูลหรือไม่ ?",
                  style: SweetAlertStyle.confirm,
                  showCancelButton: true, onPress: (bool isConfirm) {
                  if (isConfirm) {
                    setState(() {
                      saveing = false;
                    });
                    apisaveDataVisit();
                  } else {
                    SweetAlert.show(context,
                        subtitle: "Canceled!", style: SweetAlertStyle.error);
                  }
                });
        },
      ),
    );
  }

  Widget inputcomment(TextEditingController controller, String text) {
    return Container(
      margin: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      child: TextFormField(
        controller: controller,
        style: TextStyle(fontSize: 16.0),
        decoration: InputDecoration(
          hintText: text,
          labelText: text,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  Widget showcomment(
      TextEditingController controller, String text, bool enabled) {
    return Container(
      margin: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      child: TextFormField(
        enabled: enabled,
        controller: controller,
        style: TextStyle(fontSize: 16.0),
        decoration: InputDecoration(
          hintText: text,
          labelText: text,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  Widget buildpickimageAddress(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: new Icon(Icons.image),
                  title: new Text('Gallery'),
                  onTap: () {
                    Navigator.of(context).pop();
                    getImageAddresst();
                  },
                ),
              ],
            ),
          ),
        );
      },
      child: Container(
        height: 300.0,
        decoration: BoxDecoration(
          border: Border.all(color: mainColor, width: 3),
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.all(12.0),
        child: Center(
          child: _imageAddress == null
              ? Icon(Icons.image, size: 80, color: Colors.grey)
              : Image.file(_imageAddress),
        ),
      ),
    );
  }

  Widget buildpickimagevisit(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: new Icon(Icons.camera_alt),
                  title: new Text('Camera'),
                  onTap: () {
                    getImageVisit(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: new Icon(Icons.image),
                  title: new Text('Gallery'),
                  onTap: () {
                    Navigator.of(context).pop();
                    getImageVisit(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        );
      },
      child: Container(
        height: 300.0,
        decoration: BoxDecoration(
          border: Border.all(color: mainColor, width: 3),
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.all(12.0),
        child: Center(
          child: _imagevisit == null
              ? Icon(Icons.image, size: 80, color: Colors.grey)
              : Image.file(_imagevisit),
        ),
      ),
    );
  }

  Future getImageAddresst() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    print("mage.path :" + image.path);
    setState(() {
      _imageAddress = image;
    });
  }

  Future getImageVisit(ImageSource type) async {
    var image = await ImagePicker.pickImage(source: type);
    // ignore: unrelated_type_equality_checks
    if (type == "ImageSource.camera") {
      if (_imagevisit != null) {
        GallerySaver.saveImage(_imagevisit.path, albumName: 'KabinBuriApp');
      }
    }
    setState(() {
      _imagevisit = image;
    });
    print(type);
  }

  Widget border() {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Divider(color: Colors.black87),
    );
  }

  Widget titleSub(String text) {
    return Container(
      padding: EdgeInsets.only(left: 20.0),
      child: Row(
        children: <Widget>[
          Text(text,
              style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget showDatas(var data) {
    return Container(
      margin: EdgeInsets.only(left: 20.0, top: 8.0),
      width: MediaQuery.of(context).size.width,
      child: Text(data, style: TextStyle(fontSize: 18.0)),
    );
  }
}
