import 'dart:async';
import 'dart:convert';
import 'package:KABINBURI/Teacher/view-visithome.dart';
import 'package:KABINBURI/Teacher/visithome.dart';
import 'package:KABINBURI/model/student_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:KABINBURI/style/connect_api.dart';
import 'package:KABINBURI/style/contsan.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert' as convert;

import 'package:sweetalert/sweetalert.dart';

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
    var client = http.Client();
    try {
      var _url = '$api/server/student/get-student';
      var _obj = {
        "top": (top).toString(),
        "firstnameSTD": searchname.text.trim(),
        "deparment": deparmentuser,
      };
      var response = await client.post(_url, body: _obj);
      var res = json.decode(response.body);
      if (res["status"] == true) {
        students = res["result"].map((i) => Student.fromJson(i)).toList();
        setState(() {
          isLoading = false;
        });
      }
      return true;
    } finally {
      client.close();
    }
  }

  Future apiDeleteStudent(int id) async {
    var client = http.Client();
    try {
      var response = await client
          .post('$api/server/student/teacher-delete', body: {'id': '$id'});
      var data = convert.jsonDecode(response.body);
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
    } finally {
      client.close();
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
                header: WaterDropMaterialHeader(),
                footer: CustomFooter(
                  builder: (BuildContext context, LoadStatus mode) {
                    Widget body;
                    if (mode == LoadStatus.idle) {
                      body = Text("pull up load");
                    } else if (mode == LoadStatus.loading) {
                      body = CupertinoActivityIndicator();
                    } else if (mode == LoadStatus.failed) {
                      body = Text("Load Failed!Click retry!");
                    } else if (mode == LoadStatus.canLoading) {
                      body = Text("release to load more");
                    } else {
                      body = Text("No more Data");
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
                child: isLoading == true
                    ? progress()
                    : (students.length == null ? notedata() : showItem()),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget notedata() {
    return Center(
      child: Container(
        child: Text(
          'ไม่พบข้อมูล',
          style: TextStyle(
            fontSize: 50.0,
            fontWeight: FontWeight.w900,
            color: mainColor,
          ),
        ),
      ),
    );
  }

  Widget showItem() {
    return ListView.builder(
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
              child: Text("${students[i].studygroup}", style: textlistsub),
            ),
            trailing: Container(
              margin: EdgeInsets.only(right: 10.0),
              child: IconButton(
                icon: Icon(Icons.more_vert, size: 35.0),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Container(
                      child: Wrap(
                        children: <Widget>[
                          ListTile(
                            leading: new Icon(Icons.assignment_turned_in),
                            title: new Text('เยี่ยมบ้าน'),
                            onTap: () => {
                              Navigator.of(context).pop(),
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VisitHomePage(
                                      idStudent: students[i].student),
                                ),
                              )
                            },
                          ),
                          ListTile(
                            // enabled: false,
                            enabled: students[i].isVisit == 0 ? false : true,
                            leading: new Icon(Icons.assignment_ind),
                            title: new Text('บันทึกการเยี่ยมบ้าน'),
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ViewVisitHomePage(
                                          idStudent: students[i].student)));
                            },
                          ),
                          GestureDetector(
                            child: ListTile(
                              leading: new Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              title: Text('ลบข้อมูล'),
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
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
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
            style: TextStyle(fontSize: 18.0),
            controller: searchname,
            decoration: InputDecoration(
              hintText: 'ชื่อนักเรียน  นักศึกษา',
              border: InputBorder.none,
            ),
          ),
          trailing: IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              hidekeyboard();
              searchname.clear();
              setState(() {
                apiSetData();
              });
            },
          ),
        ),
      ),
    );
  }
}
