import 'dart:async';
import 'dart:convert';
import 'package:KABINBURI/Teacher/view_visit_home.dart';
import 'package:KABINBURI/Teacher/visit_home.dart';
import 'package:KABINBURI/model/student_model.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:KABINBURI/style/connect_api.dart';
import 'package:KABINBURI/style/contsan.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:sweetalert/sweetalert.dart';

import 'edit_student.dart';

class ListdataStudents extends StatefulWidget {
  ListdataStudents({Key key}) : super(key: key);

  @override
  _ListdataStudentsState createState() => _ListdataStudentsState();
}

class _ListdataStudentsState extends State<ListdataStudents> {
  var searchname = TextEditingController();
  var _refreshController = RefreshController(initialRefresh: false);
  var students, deparmentuser;
  bool visit;
  bool isLoading = true;
  Timer timer;
  var top = 10;

  @override
  void initState() {
    super.initState();
    apiSetData();
  }

  Future apiSetData() async {
    var preferences = await SharedPreferences.getInstance();
    setState(() {
      deparmentuser = preferences.getString('deparment');
    });
    try {
      var _url = '$api/server/student/get-student';
      var obj = {
        "top": (top).toString(),
        "firstnameSTD": searchname.text.trim(),
        "deparment": deparmentuser,
      };
      var _obj = jsonEncode(obj);
      var response = await http.post(_url,
          headers: {
            'content-type': 'application/json',
          },
          body: _obj);
      var res = json.decode(response.body);
      if (res["status"] == true) {
        students = res["result"].map((i) => Student.fromJson(i)).toList();
        setState(() {
          isLoading = false;
        });
      }
      return true;
    } catch (e) {
      EdgeAlert.show(context,
          title: 'กรุณาลองใหม่',
          description: '$e',
          gravity: EdgeAlert.TOP,
          backgroundColor: Colors.red);
    }
  }

  Future apiDeleteStudent(int id) async {
    try {
      var obj = {'id': '$id'};
      var _obj = jsonEncode(obj);
      var res = await http.post('$api/server/student/teacher-delete',
          headers: {
            'content-type': 'application/json',
          },
          body: _obj);
      var data = convert.jsonDecode(res.body);
      if (data['status'] == true) {
        SweetAlert.show(
          context,
          style: SweetAlertStyle.success,
          title: "Success",
        );
        setState(() {
          apiSetData();
        });
      }
      return data;
    } catch (e) {
      EdgeAlert.show(context,
          title: 'กรุณาลองใหม่',
          description: '$e',
          gravity: EdgeAlert.TOP,
          backgroundColor: Colors.red);
    }
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      top = 10;
      isLoading = false;
      apiSetData();
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    if (mounted)
      setState(() {
        top += 5;
        isLoading = false;
        apiSetData();
      });
    _refreshController.loadComplete();
  }

  void _callNumber(var number) async {
    await FlutterPhoneDirectCaller.callNumber(number);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          tabSearch(),
          Flexible(
            child: Container(
              child: SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,
                header: new MaterialClassicHeader(),
                footer: CustomFooter(
                  builder: (BuildContext context, LoadStatus mode) {
                    Widget body;
                    if (mode == LoadStatus.idle) {
                      body = Text("pull up load", style: hintStyle);
                    } else if (mode == LoadStatus.loading) {
                      body = CupertinoActivityIndicator();
                    } else if (mode == LoadStatus.failed) {
                      body = Text("Load Failed!Click retry!", style: hintStyle);
                    } else if (mode == LoadStatus.canLoading) {
                      body = Text("release to load more", style: hintStyle);
                    } else {
                      body = Text("No more Data", style: hintStyle);
                    }
                    return Container(
                      height: 55.0,
                      child: Center(child: body),
                    );
                  },
                ),
                controller: _refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: isLoading == true ? progress() : showItem(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget showItem() {
    return students.length == 0
        ? notedata()
        : ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, i) => Container(
              padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
              child: Card(
                elevation: 3.0,
                child: ListTile(
                  dense: true,
                  leading: Icon(Icons.account_circle),
                  title: Row(
                    children: [
                      Text(students[i].firstnameStd, style: textlist),
                      SizedBox(width: 10.0),
                      Text(students[i].lastnameStd, style: textlist)
                    ],
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: 5.0),
                    child:
                        Text("${students[i].studygroup}", style: textlistsub),
                  ),
                  trailing: Container(
                    margin: EdgeInsets.only(right: 10.0),
                    child: Icon(Icons.more_vert, size: 35.0),
                  ),
                  onTap: () => {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Container(
                        child: Wrap(
                          children: <Widget>[
                            // Phone
                            /*
                      ListTile(
                        enabled: students[i].phonesGd == '' ||
                                students[i].phonesG == null
                            ? false
                            : true,
                        leading: new Icon(Icons.phone),
                        title: new Text('โทรหาผู้ปกครอง', style: hintStyle),
                        onTap: () {
                          _callNumber('${students[i].phonesGd}');
                          Navigator.of(context).pop();
                        },
                      ),
                      ListTile(
                        enabled: students[i].phonesStd == '' ||
                                students[i].phonesStd == null
                            ? false
                            : true,
                        leading: new Icon(Icons.phone),
                        title: new Text('โทรหานักเรียน นักศึกษา',
                            style: hintStyle),
                        onTap: () {
                          _callNumber('${students[i].phonesStd}');
                          Navigator.of(context).pop();
                        },
                      ),
                      */
                            // End Phone

                            //  Edit Data Student
                            /*
                            ListTile(
                              leading: new Icon(Icons.create),
                              title: new Text('แก้ไขข้อมูล', style: hintStyle),
                              onTap: () {
                                Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditDataStudent(
                                            data: students[i])));
                              },
                            ),
                            */
                            //  End Edit Data Student

                            ListTile(
                              leading: new Icon(Icons.assignment_turned_in),
                              title: new Text('เยี่ยมบ้าน', style: hintStyle),
                              onTap: () async {
                                Navigator.of(context).pop();
                                var res = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            VisitHome(data: students[i])));
                                if (res) {
                                  apiSetData();
                                }
                              },
                            ),
                            ListTile(
                              enabled: students[i].isVisit == 0 ? false : true,
                              leading: new Icon(Icons.assignment_ind),
                              title: new Text('บันทึกการเยี่ยมบ้าน',
                                  style: hintStyle),
                              onTap: () {
                                Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ViewVistHome(data: students[i])));
                              },
                            ),
                            ListTile(
                              leading: new Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              title: Text('ลบข้อมูล', style: hintStyle),
                              onTap: () {
                                Navigator.of(context).pop();
                                SweetAlert.show(context,
                                    title: "คุณต้องการลบข้อมูล",
                                    subtitle:
                                        "${students[i].prefixStd} ${students[i].firstnameStd}   ${students[i].lastnameStd}   หรือไม่ ?",
                                    style: SweetAlertStyle.confirm,
                                    showCancelButton: true,
                                    // ignore: missing_return
                                    onPress: (bool isConfirm) {
                                  if (isConfirm) {
                                    apiDeleteStudent(students[i].student);
                                    return false;
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  },
                ),
              ),
            ),
          );
  }

  Widget tabSearch() {
    return Container(
      color: primaryColor,
      padding: const EdgeInsets.all(2.0),
      child: Card(
        child: ListTile(
          leading: Icon(Icons.search),
          title: TextField(
            onChanged: (value) {
              timer = new Timer(const Duration(milliseconds: 500), () {
                apiSetData();
              });
            },
            style: TextStyle(fontSize: 18.0, fontFamily: 'Mali'),
            controller: searchname,
            decoration: InputDecoration(
              hintText: 'ชื่อนักเรียน  นักศึกษา',
              hintStyle: hintStyle,
              border: InputBorder.none,
            ),
          ),
          trailing: IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              apiSetData();
              hidekeyboard();
              setState(() {
                searchname.clear();
              });
            },
          ),
        ),
      ),
    );
  }
}
