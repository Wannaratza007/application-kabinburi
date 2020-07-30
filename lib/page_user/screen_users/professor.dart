import 'dart:async';
import 'dart:convert';
import 'package:KABINBURI/models/teacher_model.dart';
import 'package:KABINBURI/style/connect_api.dart';
import 'package:KABINBURI/style/contsan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Professor extends StatefulWidget {
  Professor({Key key}) : super(key: key);

  @override
  _ProfessorState createState() => _ProfessorState();
}

class _ProfessorState extends State<Professor> {
  var username = TextEditingController();
  var _refreshController = RefreshController(initialRefresh: false);
  List<Teacher> teachers = List();
  bool isLoading = true;
  Timer timer;
  var top = 10;

  @override
  void initState() {
    apiGetDataTeacher();
    super.initState();
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      top = 10;
      isLoading = false;
      apiGetDataTeacher();
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    if (mounted)
      setState(() {
        top += 5;
        isLoading = false;
        apiGetDataTeacher();
      });
    _refreshController.loadComplete();
  }

  Future<void> apiGetDataTeacher() async {
    var client = http.Client();
    try {
      var _obj = {
        // "username": username.text,
        "top": (top).toString(),
      };
      var response = await client.post('$api/getteacher', body: _obj);
      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(response.body);
        List<dynamic> data = map["result"];
        teachers = data.map((i) => Teacher.fromJson(i)).toList();
        setState(() {
          isLoading = false;
        });
        return data;
      } else {}
    } finally {
      client.close();
    }
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
              child: (teachers) != null ? data() : progress(),
            ),
          ),
        ],
      ),
    );
  }

  Widget data() {
    return teachers.length == 0
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
            itemCount: teachers.length,
            itemBuilder: (context, index) => Container(
              child: Card(
                elevation: 3.0,
                child: ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Row(
                    children: <Widget>[
                      Text(teachers[index].firstname, style: testlist),
                      SizedBox(width: 15.0),
                      Text(teachers[index].lastname, style: testlist),
                    ],
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: 6.0),
                    child: Text(teachers[index].deparment, style: testlistsub),
                  ),
                  trailing: Wrap(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.phone,
                          color: Colors.green,
                          size: 30.0,
                        ),
                        onPressed: () => _callNumber(teachers[index].phone),
                      )
                    ],
                  ),
                ),
              ),
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

  Widget tabSearch() {
    return Container(
      color: primaryColor,
      padding: const EdgeInsets.all(2.0),
      child: Card(
        child: ListTile(
          leading: Icon(Icons.search),
          title: TextField(
            style: TextStyle(fontSize: 18.0),
            controller: username,
            decoration: InputDecoration(
              hintText: 'ชื่อผู้ใช้งาน',
              border: InputBorder.none,
            ),
            onChanged: (value) {
              timer = new Timer(const Duration(milliseconds: 200), () {
                print('TIME');
                apiGetDataTeacher();
              });
            },
          ),
          trailing: IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              username.clear();
              setState(() {
                apiGetDataTeacher();
              });
            },
          ),
        ),
      ),
    );
  }

  _callNumber(number) async {
    await FlutterPhoneDirectCaller.callNumber(number);
  }
}
