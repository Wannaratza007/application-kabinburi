import 'package:KABINBURI/models/student_by_id_model.dart';
import 'package:KABINBURI/style/connect_api.dart';
import 'package:KABINBURI/style/contsan.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

// ignore: must_be_immutable
class ViewDataVisit extends StatefulWidget {
  int id;
  ViewDataVisit({Key key, this.id}) : super(key: key);
  @override
  _ViewDataVisitState createState() => _ViewDataVisitState();
}

class _ViewDataVisitState extends State<ViewDataVisit> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          prints(),
          visiter(context),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: getstudents.length == null ? progress() : listdata(),
      ),
    );
  }

  Widget visiter(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.0),
      child: IconButton(
        tooltip: 'เยี่บมบ้านนักศึกษา',
        icon: Icon(Icons.assignment_turned_in),
        onPressed: () {
          print(widget.id);
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => VisitHomeStudent(id: widget.id),
          //   ),
          // );
        },
      ),
    );
  }

  Widget prints() {
    return Container(
      margin: EdgeInsets.only(right: 10.0),
      child: IconButton(
        tooltip: 'ปริ้นรูปภาพ',
        icon: Icon(Icons.print),
        onPressed: () {},
      ),
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
                ],
              ),
            ),
          ),
        ),
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
        //     child: ListView.builder(
        //       scrollDirection: Axis.horizontal,
        //       itemBuilder: (context, index) => Container()
        //     )
        //     // child: ListView(
        //     //   scrollDirection: Axis.horizontal,
        //     //   children: <Widget>[
        //     //     images(),
        //     //     images(),
        //     //     images(),
        //     //     images(),
        //     //   ],
        //     // ),
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
              child: Icon(
                Icons.image,
                size: 80.0,
                color: Colors.grey,
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
}
