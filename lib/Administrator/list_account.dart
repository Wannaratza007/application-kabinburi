import 'dart:async';
import 'dart:convert';
import 'package:KABINBURI/model/user_model.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:http/http.dart' as http;
import 'package:KABINBURI/style/connect_api.dart';
import 'package:KABINBURI/style/contsan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sweetalert/sweetalert.dart';

class ListAccounting extends StatefulWidget {
  ListAccounting({Key key}) : super(key: key);

  @override
  _ListAccountingState createState() => _ListAccountingState();
}

class _ListAccountingState extends State<ListAccounting> {
  var _refreshController = RefreshController(initialRefresh: false);
  var searchname = TextEditingController();
  Timer timer;
  bool isLoading = true;
  int top = 10;
  var account;

  @override
  void initState() {
    super.initState();
    apilistAccount();
  }

  Future apilistAccount() async {
    try {
      var _url = '$api/server/user/list-users';
      var obj = {
        "top": top,
        "firstnameSTD": searchname.text.trim(),
      };
      var _obj = jsonEncode(obj);
      var response = await http.post(_url,
          headers: {
            'content-type': 'application/json',
          },
          body: _obj);
      var res = json.decode(response.body);
      if (res["status"] == true) {
        account = res["result"].map((i) => User.fromJson(i)).toList();
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      EdgeAlert.show(context,
          title: 'กรุณาลองใหม่',
          description: '$e',
          gravity: EdgeAlert.TOP,
          backgroundColor: Colors.red);
    }
  }

  Future apideleteAccount(var userId) async {
    try {
      var _url = '$api/server/user/delete-user';
      var obj = {
        "id": (userId).toString(),
      };
      var _obj = jsonEncode(obj);
      var response = await http.post(_url,
          headers: {
            'content-type': 'application/json',
          },
          body: _obj);
      var res = json.decode(response.body);
      if (res["status"] == true) {
        SweetAlert.show(
          context,
          style: SweetAlertStyle.success,
          title: "Success",
        );
        setState(() {
          apilistAccount();
        });
      }
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
      apilistAccount();
      searchname.clear();
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    if (mounted)
      setState(() {
        top += 5;
        isLoading = false;
        apilistAccount();
        searchname.clear();
      });
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Account', style: hintStyle),
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
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
    return account.length == 0
        ? notedata()
        : ListView.builder(
            itemCount: account.length,
            itemBuilder: (context, i) => Container(
              padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
              child: Card(
                elevation: 3.0,
                child: ListTile(
                  onTap: () => showModalBottomSheet(
                    context: context,
                    builder: (context) => Container(
                      child: Wrap(
                        children: <Widget>[
                          ListTile(
                            leading: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            title: Text('ลบข้อมูล', style: hintStyle),
                            onTap: () {
                              Navigator.of(context).pop();
                              SweetAlert.show(context,
                                  title: "คุณต้องการลบข้อมูล",
                                  subtitle:
                                      "คุณ  ${account[i].firstname}  แผนก${account[i].deparmentName}   หรือไม่ ?",
                                  style: SweetAlertStyle.confirm,
                                  showCancelButton: true,
                                  // ignore: missing_return
                                  onPress: (bool isConfirm) {
                                if (isConfirm) {
                                  apideleteAccount(account[i].userId);
                                  return false;
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  leading: Icon(Icons.account_circle),
                  title: Row(
                    children: [
                      Text(account[i].firstname, style: textlist),
                      SizedBox(width: 10.0),
                      Text(account[i].lastname, style: textlist)
                    ],
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: 5.0),
                    child: Row(
                      children: [
                        Text("แผนกวิชา  ${account[i].deparmentName}",
                            style: textlistsub),
                      ],
                    ),
                  ),
                  trailing: Container(
                    margin: EdgeInsets.only(right: 10.0),
                    child: Icon(Icons.more_vert, size: 35.0)
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
              timer = new Timer(const Duration(milliseconds: 100), () {
                apilistAccount();
              });
            },
            style: TextStyle(fontSize: 18.0, fontFamily: 'Mali'),
            controller: searchname,
            decoration: InputDecoration(
              hintText: 'ชื่อบัญชีผู้ใช้',
              hintStyle: hintStyle,
              border: InputBorder.none,
            ),
          ),
          trailing: IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              hidekeyboard();
              searchname.clear();
              setState(() {
                apilistAccount();
              });
            },
          ),
        ),
      ),
    );
  }
}
