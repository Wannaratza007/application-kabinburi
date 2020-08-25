import 'dart:async';
import 'dart:convert';
import 'dart:convert' as convert;
import 'package:KABINBURI/models/user_model.dart';
import 'package:KABINBURI/page_admin/screen_admin/new_account.dart';
import 'package:KABINBURI/style/connect_api.dart';
import 'package:KABINBURI/style/contsan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sweetalert/sweetalert.dart';

class Accounting extends StatefulWidget {
  Accounting({Key key}) : super(key: key);

  @override
  _AccountingState createState() => _AccountingState();
}

class _AccountingState extends State<Accounting> {
  TextEditingController username = TextEditingController();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<UserModel> getusers = List();
  bool isLoading = true;
  Timer timer;
  var top = 10;

  @override
  void initState() {
    apiGetDataUser();
    super.initState();
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      top = 10;
      isLoading = false;
      apiGetDataUser();
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    if (mounted)
      setState(() {
        top += 5;
        isLoading = false;
        apiGetDataUser();
      });
    _refreshController.loadComplete();
  }

  Future apiGetDataUser() async {
    var client = http.Client();
    try {
      var _obj = {
        "username": username.text,
        "top": (top).toString(),
      };
      var response = await client.post('$api/getuser', body: _obj);
      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(response.body);
        List<dynamic> data = map["result"];
        getusers = data.map((i) => UserModel.fromJson(i)).toList();
        setState(() {
          isLoading = false;
        });
        return data;
      } else {}
    } finally {
      client.close();
    }
  }

  Future apiDeleteuser(int id) async {
    print(id);
    var client = http.Client();
    try {
      var response = await client.post('$api/deleteUser', body: {"id": "$id"});
      if (response.statusCode == 200) {
        var data = convert.jsonDecode(response.body);
        if (data['status'] == true) {
          SweetAlert.show(
            context,
            style: SweetAlertStyle.success,
            title: "Success",
          );
          setState(() {
            apiGetDataUser();
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
        backgroundColor: Colors.white,
        title: Text(
          'จัดการบัญชีผู้งานใช้',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
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
              child: (getusers) != null ? data() : progress(),
            ),
          ),
        ],
      ),
    );
  }

  Widget data() {
    return getusers.length == 0
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
            itemCount: getusers.length,
            itemBuilder: (context, index) => Container(
              child: Card(
                elevation: 3.0,
                child: ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Row(
                    children: <Widget>[
                      Text(getusers[index].firstname, style: testlist),
                      SizedBox(width: 15.0),
                      Text(getusers[index].lastname, style: testlist),
                    ],
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: 6.0),
                    child: Text(getusers[index].status, style: testlistsub),
                  ),
                  trailing: Wrap(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          SweetAlert.show(context,
                              title: "คุณต้องการลบข้อมูล",
                              subtitle:
                                  "${getusers[index].firstname}   สถานะ  ${getusers[index].status}   หรือไม่ ?",
                              style: SweetAlertStyle.confirm,
                              showCancelButton: true,
                              onPress: (bool isConfirm) {
                            if (isConfirm) {
                              apiDeleteuser(getusers[index].userID);
                              return false;
                            }
                          });
                        },
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

  Widget demoData(BuildContext context) {
    return Container(
      height: 80.0,
      // padding: EdgeInsets.all(8.0),
      child: Card(
        elevation: 3.0,
        child: GestureDetector(
          child: ListTile(
            leading: Icon(Icons.account_circle),
            title: Container(
              child: Row(
                children: <Widget>[
                  Text('First Name'),
                  SizedBox(width: 15.0),
                  Text('Last Name'),
                ],
              ),
            ),
            subtitle: Container(
              margin: EdgeInsets.only(top: 7.0),
              child: Text('Status'),
            ),
            trailing: Container(
              child: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {},
              ),
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddAccount(),
              ),
            );
          },
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
                apiGetDataUser();
              });
            },
          ),
          trailing: IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              username.clear();
              setState(() {
                apiGetDataUser();
              });
            },
          ),
        ),
      ),
    );
  }
}
