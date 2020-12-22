import 'package:KABINBURI/style/contsan.dart';
import 'package:KABINBURI/style/singout.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';

import 'list_account.dart';

class ProflieAdmin extends StatefulWidget {
  ProflieAdmin({Key key}) : super(key: key);

  @override
  _ProflieAdminState createState() => _ProflieAdminState();
}

class _ProflieAdminState extends State<ProflieAdmin> {
  String firstnameuser, lastnameuser;

  @override
  void initState() {
    finduser();
    if (mounted) {
      super.initState();
    }
  }

  Future finduser() async {
    var pfs = await SharedPreferences.getInstance();
    setState(() {
      firstnameuser = pfs.getString('firstname');
      lastnameuser = pfs.getString('lastname');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: indexColor),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 80.0,
                      height: 80.0,
                      child: Image.asset('assets/images/user.png'),
                    ),
                    SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          firstnameuser == null
                              ? 'Administrator'
                              : firstnameuser,
                          style: TextStyle(fontSize: 18.0),
                        ),
                        SizedBox(width: 15.0),
                        Text(
                          lastnameuser == null ? '' : lastnameuser,
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.apps),
              trailing: Icon(Icons.arrow_forward_ios),
              title: Text('จัดการบัญชี', style: TextStyle(fontSize: 18.0)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListAccounting()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.red),
              title: Text(
                'ออกจากระบบ',
                style: TextStyle(fontSize: 18.0, color: Colors.red),
              ),
              onTap: () {
                SweetAlert.show(context,
                    subtitle: "คุณต้องการออกจากระบบหรือไม่ ?",
                    style: SweetAlertStyle.confirm,
                    // ignore: missing_return
                    showCancelButton: true, onPress: (bool isConfirm) {
                  if (isConfirm) {
                    logout(context);
                    return false;
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
