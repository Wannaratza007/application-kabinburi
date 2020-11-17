import 'dart:async';
import 'package:KABINBURI/models/student_model.dart';
import 'package:KABINBURI/style/connect_api.dart';
import 'package:KABINBURI/style/contsan.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'dart:convert';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sweetalert/sweetalert.dart';

class PageListDataDelete extends StatefulWidget {
  PageListDataDelete({Key key}) : super(key: key);

  @override
  _PageListDataDeleteState createState() => _PageListDataDeleteState();
}

class _PageListDataDeleteState extends State<PageListDataDelete> {
  TextEditingController controller = TextEditingController();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<GetStudent> getstudents;
  bool isLoading = true;
  Timer timer;
  var top = 10;

  @override
  void initState() {
    super.initState();
    apiListdelete();
    isLoading = true;
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      top = 10;
      isLoading = false;
      apiListdelete();
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    if (mounted)
      setState(() {
        top += 5;
        isLoading = false;
        apiListdelete();
      });
    _refreshController.loadComplete();
  }

  Future apiListdelete() async {
    var client = http.Client();
    try {
      var _obj = {
        "firstNameSTD": controller.text,
        "top": (top).toString(),
      };
      var response = await client.post('$api/getdelete', body: _obj);
      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(response.body);
        List<dynamic> data = map["result"];
        getstudents = data.map((i) => GetStudent.fromJson(i)).toList();
        setState(() {
          isLoading = false;
        });
        return data;
      } else {}
    } finally {
      client.close();
    }
  }

  Future apiDeletedata(int id) async {
    print(id);
    var client = http.Client();
    try {
      var response =
          await client.post('$api/deleteDataStudent', body: {"id": "$id"});
      if (response.statusCode == 200) {
        var data = convert.jsonDecode(response.body);
        if (data['status'] == true) {
          SweetAlert.show(
            context,
            style: SweetAlertStyle.success,
            title: "Success",
          );
          setState(() {
            apiListdelete();
          });
        }
        return data;
      }
    } finally {
      client.close();
    }
  }

  Future apiReuserData(int id) async {
    print(id);
    var client = http.Client();
    try {
      var response =
          await client.post('$api/reusedatdelete', body: {"id": "$id"});
      if (response.statusCode == 200) {
        var data = convert.jsonDecode(response.body);
        if (data['status'] == true) {
          SweetAlert.show(
            context,
            style: SweetAlertStyle.success,
            title: "Success",
          );
          setState(() {
            apiListdelete();
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
                child: isLoading == true ? progress() : showItem(),
                // ? progress()
                // : (getstudents.length == 0 ? notedata() : showItem()),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget showItem() {
    return ListView.builder(
      itemCount: getstudents.length,
      itemBuilder: (context, index) => Container(
        child: Card(
          elevation: 3.0,
          child: ListTile(
            leading: Icon(Icons.account_circle),
            title: Row(
              children: <Widget>[
                Text(getstudents[index].firstNameSTD, style: testlist),
                SizedBox(width: 10.0),
                Text(getstudents[index].lastNameSTD, style: testlist),
              ],
            ),
            subtitle: Container(
              margin: EdgeInsets.only(top: 5.0),
              child: Text(getstudents[index].deparment, style: testlistsub),
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
                            onTap: () => {
                              Navigator.of(context).pop(),
                              apiReuserData(getstudents[index].studenID),
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
                                  apiDeletedata(getstudents[index].studenID);
                                  return false;
                                }
                              }),
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            onTap: () {
              print(getstudents[index].studenID);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) =>
              //         ViewDataVisit(id: getstudents[index].studenID),
              //   ),
              // );
            },
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
            onChanged: (value) {
              timer = new Timer(const Duration(milliseconds: 800), () {
                print('TIME');
                apiListdelete();
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
              setState(() {
                apiListdelete();
              });
            },
          ),
        ),
      ),
    );
  }
}
