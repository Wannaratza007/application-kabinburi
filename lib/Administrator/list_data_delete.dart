import 'dart:async';
import 'dart:convert';
import 'package:KABINBURI/model/student_model.dart';
import 'package:KABINBURI/style/connect_api.dart';
import 'package:http/http.dart' as http;
import 'package:KABINBURI/style/contsan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sweetalert/sweetalert.dart';

class ListDataDeletePage extends StatefulWidget {
  ListDataDeletePage({Key key}) : super(key: key);

  @override
  _ListDataDeletePageState createState() => _ListDataDeletePageState();
}

class _ListDataDeletePageState extends State<ListDataDeletePage> {
  var searchname = TextEditingController();
  var _refreshController = RefreshController(initialRefresh: false);
  var students;
  bool isLoading = true;
  Timer timer;
  var top = 10;

  @override
  void initState() {
    super.initState();
    apiSetData();
  }

  Future apiSetData() async {
    var client = http.Client();
    try {
      var _url = '$api/server/student/get-student-delete';
      var _obj = {
        "top": (top).toString(),
        "firstnameSTD": searchname.text.trim(),
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

  Future apitrailing(String type, int id) async {
    print(id);
    var client = http.Client();
    try {
      var url;
      if (type == 'reuse') {
        url = 'reuse-student';
      } else {
        url = 'delete-student';
      }
      var _url = '$api/server/student/$url';
      var response = await client.post(_url, body: {"id": "$id"});
      var result = json.decode(response.body);
      if (result['status'] == true) {
        SweetAlert.show(
          context,
          style: SweetAlertStyle.success,
          title: "Success",
        );
        setState(() {
          apiSetData();
        });
      }
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
                    : (students.length == 0 ? notedata() : showItem()),
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
                            leading: new Icon(Icons.loop),
                            title: new Text('กู้ข้อมูลนักศึกษา'),
                            onTap: () {
                              Navigator.of(context).pop();
                              apitrailing('reuse', students[i].student);
                            },
                          ),
                          ListTile(
                            leading: Icon(
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
                                  onPress: (bool isConfirm) {
                                if (isConfirm) {
                                  apitrailing('delete', students[i].student);
                                  return false;
                                }
                              });
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
