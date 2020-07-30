import 'package:KABINBURI/models/student_by_id_model.dart';
import 'package:KABINBURI/page_teacher/screen_teacher/visit_home/signature/signature.dart';
import 'package:KABINBURI/style/connect_api.dart';
import 'package:KABINBURI/style/contsan.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:sweetalert/sweetalert.dart';

// ignore: must_be_immutable
class VisitHome extends StatefulWidget {
  int id;
  VisitHome({Key key, this.id}) : super(key: key);
  @override
  _VisitHomeState createState() => _VisitHomeState();
}

class _VisitHomeState extends State<VisitHome> {
  final _formKey = GlobalKey<FormState>();
  var behaviorD = TextEditingController();
  var behaviorNotD = TextEditingController();
  var problem = TextEditingController();
  var suggestion = TextEditingController();
  File _image;
  List<DataStudentByID> getstudents = List();

  @override
  void initState() {
    apiListDataStudenByID(widget.id);
    super.initState();
  }

  Future<void> apiListDataStudenByID(int id) async {
    var client = http.Client();
    try {
      var response =
          await client.post('$api/getStudentById', body: {'id': '$id'});
      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(response.body);
        List<dynamic> data = map["result"];
        for (var map in data) {
          var getstudent = DataStudentByID.fromJson(map);
          setState(() {
            getstudents.add(getstudent);
          });
        }
        return data;
      }
    } finally {
      client.close();
    }
  }

  Future getImage(String type) async {
    var image;
    if (type == 'camera') {
      image = await ImagePicker.pickImage(source: ImageSource.camera);
      print(image.path);
      if (image != null && image.path != null) {
        GallerySaver.saveImage(image.path, albumName: 'VisitHome');
      }
    } else if (type == 'gallery') {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    }
    if (image == null) return null;
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: getstudents.length == null ? progress() : listdata(),
        ),
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('เยี่ยมบ้านนักศึกษา'),
      leading: iconBack(context),
      actions: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 10.0),
          child: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SignturePage(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget iconBack(BuildContext context) {
    return IconButton(
      color: Colors.black,
      icon: Icon(Icons.arrow_back_ios, color: Colors.white),
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  Widget listdata() {
    return ListView.builder(
      itemCount: getstudents.length,
      itemBuilder: (context, index) => Container(
        child: Card(
          elevation: 2.0,
          child: Container(
            padding: EdgeInsets.only(bottom: 30.0),
            child: Container(
              margin: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  title(),
                  Divider(color: Colors.black87),
                  titleSub('ชื่อ / นามสกุล'),
                  name(index),
                  titleSub('ระดับ / แผนก'),
                  group(index),
                  titleSub('วัน / เวลา ที่ไปเยี่ยม'),
                  selecteTime(),
                  titleSub('รูปภาพ'),
                  showimages(),
                  titleSub('Commennt พฤติกรรมนักศึกษา'),
                  inputcomment(behaviorD, 'พฤติกรรมด้านที่ดี'),
                  inputcomment(behaviorNotD, 'พฤติกรรมด้านที่ต้องปรับปรุง'),
                  titleSub('ปัญหา / แนวทางการแก้ปัญหา'),
                  inputcomment(problem, 'แนวทางการแก้ปัญหาาร่วมกันผู้ปกครอง'),
                  titleSub('ข้อเสนอแนะ'),
                  inputcomment(
                      suggestion, 'แนวทางการแก้ปัญหาาร่วมกันผู้ปกครอง'),
                  buttonSVAE(),
                ],
              ),
            ),
          ),
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
          SweetAlert.show(context,
              subtitle: "คุณต้องการบันทึกข้อมูลหรือไม่ ?",
              style: SweetAlertStyle.confirm,
              showCancelButton: true, onPress: (bool isConfirm) {
            if (isConfirm) {
              SweetAlert.show(context,
                  subtitle: "Save...", style: SweetAlertStyle.loading);
              new Future.delayed(new Duration(seconds: 2), () {
                SweetAlert.show(context,
                    subtitle: "Success!", style: SweetAlertStyle.success);
              });
            } else {
              SweetAlert.show(context,
                  subtitle: "Canceled!", style: SweetAlertStyle.error);
            }
            // return false to keep dialog
            return false;
          });
        },
      ),
    );
  }

  Widget group(int index) {
    return Container(
      margin: EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Text(
                  getstudents[index].studygroup == null
                      ? ''
                      : getstudents[index].studygroup,
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 14.0),
            child: Row(
              children: <Widget>[
                Text(
                  'แผนกวิชา',
                  style: TextStyle(fontSize: 16.0),
                ),
                Text(
                  getstudents[index].deparment == null
                      ? ''
                      : getstudents[index].deparment,
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget name(int index) {
    return Container(
      margin: EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  getstudents[index].prefixSTD == null
                      ? ''
                      : getstudents[index].prefixSTD,
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500),
                ),
                SizedBox(width: 2.0),
                Text(
                  getstudents[index].firstNameSTD == null
                      ? ''
                      : getstudents[index].firstNameSTD,
                  style: TextStyle(fontSize: 17.0),
                ),
                SizedBox(width: 12.0),
                Text(
                  getstudents[index].lastNameSTD == null
                      ? ''
                      : getstudents[index].lastNameSTD,
                  style: TextStyle(fontSize: 17.0),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 15.0),
                child: Text(
                  getstudents[index].phonesSTD.length == 0
                      ? 'ไม่พบเบอร์ติดต่อ'
                      : getstudents[index].phonesSTD,
                  style: TextStyle(fontSize: 17.0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget showimages() {
    return Container(
      height: 380.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(5.0),
      child: Card(
        elevation: 8.0,
        // child: ListView.builder(
        //   scrollDirection: Axis.horizontal,
        //   itemBuilder: (context, index) => Container()
        // )
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            images(),
            images(),
            images(),
            images(),
          ],
        ),
      ),
    );
  }

  Widget images() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: _image == null
          ? Container(
              decoration: BoxDecoration(color: mainColor),
              width: 270.0,
              child: IconButton(
                icon: Icon(
                  Icons.image,
                  size: 100.0,
                  color: Colors.grey,
                ),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Container(
                      child: Wrap(
                        children: <Widget>[
                          ListTile(
                            leading: new Icon(Icons.camera),
                            title: new Text('Camara'),
                            onTap: () => {
                              getImage('camera'),
                              Navigator.pop(context),
                            },
                          ),
                          new ListTile(
                            leading: new Icon(Icons.image),
                            title: new Text('Gallery'),
                            onTap: () => {
                              getImage('gallery'),
                              Navigator.pop(context),
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          : Image.file(_image),
    );
  }

  Widget selecteTime() {
    return Container(
      margin: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
      child: TextField(
        style: TextStyle(fontSize: 16.0),
        decoration: InputDecoration(border: OutlineInputBorder()),
      ),
    );
  }

  Widget titleSub(String text) {
    return Container(
      padding: EdgeInsets.only(top: 15.0, left: 10.0),
      child: Row(
        children: <Widget>[
          Text(text,
              style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget title() {
    return Container(
      padding: EdgeInsets.only(top: 15.0, left: 15.0),
      child: Row(
        children: <Widget>[
          Container(child: Icon(Icons.list)),
          Container(
              child: Text(
            'ข้อมูลนักศึกษา',
            style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.w600),
          )),
        ],
      ),
    );
  }

  Widget inputcomment(TextEditingController controller, String hini) {
    return Container(
      margin: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      child: TextFormField(
        controller: controller,
        style: TextStyle(fontSize: 16.0),
        decoration: InputDecoration(
          hintText: hini,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
