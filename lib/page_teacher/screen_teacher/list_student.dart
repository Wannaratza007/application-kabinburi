import 'dart:async';
import 'dart:convert';
import 'package:KABINBURI/page_teacher/screen_teacher/visit_home/view_Visit.dart';
import 'package:KABINBURI/page_teacher/screen_teacher/visit_home/visit_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:KABINBURI/models/student_model.dart';
import 'package:KABINBURI/style/connect_api.dart';
import 'package:KABINBURI/style/contsan.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert' as convert;

import 'package:sweetalert/sweetalert.dart';

class DataStudent extends StatefulWidget {
  DataStudent({Key key}) : super(key: key);
  @override
  _DataStudentState createState() => _DataStudentState();
}

class _DataStudentState extends State<DataStudent> {
  var controller = TextEditingController();
  var _refreshController = RefreshController(initialRefresh: false);
  List<GetStudent> getstudents;
  bool isloading;
  String deparmentuser;
  Timer timer;
  var top = 10;

  @override
  void initState() {
    isloading = true;
    apiListdataStudent();
    super.initState();
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1500));
    setState(() {
      top = 10;
      isloading = false;
      apiListdataStudent();
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    if (mounted)
      setState(() {
        top += 5;
        isloading = false;
        apiListdataStudent();
      });
    await Future.delayed(Duration(milliseconds: 1500));
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          tabSearch(),
          Flexible(
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
                  body = Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CupertinoActivityIndicator(),
                      SizedBox(width: 10.0),
                      Text('Loading...')
                    ],
                  );
                } else if (mode == LoadStatus.failed) {
                  body = Text("Load Failed!Click retry!");
                } else if (mode == LoadStatus.canLoading) {
                  body = Text("release to load data");
                } else {
                  body = Text("No more Data");
                }
                return Container(
                  height: 55.0,
                  child: Center(child: body),
                );
              }),
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: (getstudents) != null ? data() : progress(),
            ),
          ),
        ],
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
              timer = new Timer(const Duration(milliseconds: 200), () {
                apiListdataStudent();
              });
            },
            style: TextStyle(fontSize: 18.0),
            controller: controller,
            decoration: InputDecoration(
              hintText: 'ชื่อจริง นักเรียน  นักศึกษา',
              border: InputBorder.none,
            ),
          ),
          trailing: IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              controller.clear();
            },
          ),
        ),
      ),
    );
  }

  Widget data() {
    return getstudents.length == 0
        ? Center(
            child: Text(
              'ไม่พบข้อมูล',
              style: TextStyle(
                fontSize: 50.0,
                fontWeight: FontWeight.w900,
                color: mainColor,
              ),
            ),
          )
        : ListView.builder(
            itemCount: (getstudents) != null ? getstudents.length : 0,
            itemBuilder: (context, index) => Container(
              child: Card(
                elevation: 3.0,
                child: ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Container(
                    margin: EdgeInsets.only(top: 5.0),
                    child: Row(
                      children: <Widget>[
                        Text(getstudents[index].firstNameSTD, style: testlist),
                        SizedBox(width: 10.0),
                        Text(getstudents[index].lastNameSTD, style: testlist),
                      ],
                    ),
                  ),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(getstudents[index].studygroup,
                              style: testlistsub),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            getstudents[index].deparment,
                            style: testlistsub,
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: IconButton(
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
                                      builder: (context) => VisitHome(
                                          id: getstudents[index].studenID),
                                    ),
                                  )
                                },
                              ),
                              ListTile(
                                leading: new Icon(Icons.assignment_ind),
                                title: new Text('บันทึกการเยี่ยมบ้าน'),
                                onTap: () => {
                                  Navigator.of(context).pop(),
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ViewDataVisit(
                                          id: getstudents[index].studenID),
                                    ),
                                  )
                                },
                              ),
                              new ListTile(
                                leading: new Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                title: new Text('ลบข้อมูล'),
                                onTap: () => {
                                  Navigator.of(context).pop(),
                                  SweetAlert.show(context,
                                      title: "คุณต้องการลบข้อมูล",
                                      subtitle:
                                          "${getstudents[index].prefixSTD} ${getstudents[index].firstNameSTD}   ${getstudents[index].lastNameSTD}   หรือไม่ ?",
                                      style: SweetAlertStyle.confirm,
                                      showCancelButton: true,
                                      onPress: (bool isConfirm) {
                                    if (isConfirm) {
                                      apiDeleteStudent(
                                          getstudents[index].studenID);
                                      return false;
                                    }
                                  })
                                },
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
          );
  }

  Future apiListdataStudent() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      isloading = true;
      deparmentuser = preferences.getString('deparment');
      print(deparmentuser);
    });
    var client = http.Client();
    try {
      var _obj = {
        'Deparment': deparmentuser,
        "firstNameSTD": controller.text,
        "top": (top).toString()
      };
      var response =
          await client.post('$api/gettStudentByDeparmentStudent', body: _obj);
      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(response.body);
        List<dynamic> data = map["result"];
        getstudents = data.map((i) => GetStudent.fromJson(i)).toList();
        setState(() {
          isloading = false;
        });
      }
    } finally {
      client.close();
    }
  }

  Future apiDeleteStudent(int id) async {
    var client = http.Client();
    try {
      var response =
          await client.post('$api/daleteStudent', body: {'id': '$id'});
      var data = convert.jsonDecode(response.body);
      if (data['status'] == true) {
        SweetAlert.show(
          context,
          style: SweetAlertStyle.success,
          title: "Success",
        );
        setState(() {
          apiListdataStudent();
        });
      }
      return data;
    } finally {
      client.close();
    }
  }
}
