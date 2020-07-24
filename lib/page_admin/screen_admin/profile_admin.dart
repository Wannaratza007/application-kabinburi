import 'package:KABINBURI/page_admin/screen_admin/list_accounting.dart';
import 'package:KABINBURI/page_admin/screen_admin/new_community.dart';
import 'package:KABINBURI/page_admin/screen_admin/new_messages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:KABINBURI/style/contsan.dart';
import 'package:KABINBURI/style/singout.dart';
import 'package:flutter/material.dart';
import 'package:sweetalert/sweetalert.dart';

class PageProfileAdmin extends StatefulWidget {
  PageProfileAdmin({Key key}) : super(key: key);

  @override
  _PageProfileAdminState createState() => _PageProfileAdminState();
}

class _PageProfileAdminState extends State<PageProfileAdmin> {
  String firstnameuser, lastnameuser;

  @override
  void initState() {
    finduser();
    if (mounted) {
      super.initState();
    }
  }

  // void dispose() {
  //   super.dispose();
  // }

  Future<void> finduser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      firstnameuser = preferences.getString('firstname');
      lastnameuser = preferences.getString('lastname');
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
                  MaterialPageRoute(builder: (context) => Accounting()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.apps),
              trailing: Icon(Icons.arrow_forward_ios),
              title: Text('เพิ่มข่าวสาร', style: TextStyle(fontSize: 18.0)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddNewMessages()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.apps),
              trailing: Icon(Icons.arrow_forward_ios),
              title: Text('เพิ่มกิจกรรม', style: TextStyle(fontSize: 18.0)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddNewCommunoty()),
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
