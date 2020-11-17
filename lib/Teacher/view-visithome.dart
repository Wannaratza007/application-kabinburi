import 'dart:convert';
import 'dart:io';
import 'package:KABINBURI/model/studentID_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:KABINBURI/model/student_model.dart';
import 'package:KABINBURI/style/connect_api.dart';
import 'package:KABINBURI/style/contsan.dart';
import 'package:flutter/material.dart';

class ViewVisitHomePage extends StatefulWidget {
  int idStudent;
  ViewVisitHomePage({Key key, this.idStudent}) : super(key: key);

  @override
  _ViewVisitHomePageState createState() => _ViewVisitHomePageState();
}

class _ViewVisitHomePageState extends State<ViewVisitHomePage> {
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

  @override
  void initState() {
    super.initState();
    apiGetDataID();
  }

  Future apiGetDataID() async {
    var client = http.Client();
    try {
      var _url = '$api/server/student/get-studentId';
      var _obj = {
        "id": (widget.idStudent).toString(),
      };
      var response = await client.post(_url, body: _obj);
      var res = json.decode(response.body);
      if (res["status"] == true) {
        for (var item in res["result"]) {
          students = StudentId.fromJson(item);
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
            behaviorD.text =
                students.behaviorD == null ? '-' : students.behaviorD;
            behaviorNotD.text =
                students.behaviorNotD == null ? '-' : students.behaviorNotD;
            problem.text = students.problem == null ? '-' : students.problem;
            nameGD.text =
                students.nameParents == null ? '-' : students.nameParents;
            nameTHVisit.text =
                students.visitBy == null ? '-' : students.visitBy;
            suggestion.text =
                students.suggestion == null ? '-' : students.suggestion;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
                child: students.firstnameStd == null
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text('ไม่พบข้อมูล')],
                        ),
                      )
                    : viewData(context),
              ),
            ),
    );
  }

  Widget viewData(BuildContext context) {
    return ListView(children: <Widget>[
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
      inputcomment(behaviorD, 'พฤติกรรม ด้านดี', 'พฤติกรรม ด้านดี'),
      inputcomment(
          behaviorNotD, 'พฤติกรรม ที่ต้องปรับหรุง', 'พฤติกรรม ที่ต้องปรับหรุง'),
      SizedBox(height: 15.0),
      titleSub('ปัญหาของนักศึกษา'),
      inputcomment(problem, 'พฤติกรรม ด้านดี', 'พฤติกรรม ด้านดี'),
      SizedBox(height: 15.0),
      titleSub('ข้อเสนอแนะ'),
      inputcomment(suggestion, 'อื่นๆ...', 'อื่นๆ...'),
      SizedBox(height: 15.0),
      titleSub('ชื่อผู้ปกครอง'),
      inputcomment(nameGD, 'ชื่อผู้ปกครอง', 'ชื่อผู้ปกครอง'),
      SizedBox(height: 15.0),
      titleSub('ชื่อครูผู้ไปเยี่ยม'),
      inputcomment(nameTHVisit, 'ชื่อผู้ปกครอง', 'ชื่อผู้ปกครอง'),
      buttonSVAE(),
      SizedBox(height: 15.0),
    ]);
  }

  Widget buttonSVAE() {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(8.0),
      height: 65.0,
      child: RaisedButton(
        child: Text(
          'PRINT',
          style: TextStyle(
            fontSize: 24.0,
          ),
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        textColor: Colors.white,
        color: Colors.blue,
        onPressed: () {},
      ),
    );
  }

  Widget inputcomment(
      TextEditingController controller, String hini, String label) {
    return Container(
      margin: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      child: TextFormField(
        enabled: false,
        controller: controller,
        style: TextStyle(fontSize: 16.0),
        decoration: InputDecoration(
          hintText: hini,
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  Widget buildpickimageAddress(BuildContext context) {
    return Container(
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
    );
  }

  Widget buildpickimagevisit(BuildContext context) {
    return Container(
      height: 300.0,
      decoration: BoxDecoration(
        border: Border.all(color: mainColor, width: 3),
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.all(12.0),
      // child: Center(
      //   child: _imagevisit == null
      //       ? Icon(Icons.image, size: 80, color: Colors.grey)
      //       : Image.file(_imagevisit),
      // ),
      // child: CachedNetworkImage(
      //   imageUrl: '$api/downloads/image_tablet/dispatch/$nameImg',
      //   fit: BoxFit.cover,
      // ),
    );
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
