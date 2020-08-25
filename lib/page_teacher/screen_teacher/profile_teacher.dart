import 'package:KABINBURI/page_admin/screen_admin/new_community.dart';
import 'package:KABINBURI/page_admin/screen_admin/new_messages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:KABINBURI/style/contsan.dart';
import 'package:KABINBURI/style/singout.dart';
import 'package:flutter/material.dart';
import 'package:sweetalert/sweetalert.dart';

class PageProfileTeacher extends StatefulWidget {
  PageProfileTeacher({Key key}) : super(key: key);

  @override
  _PageProfileTeacherState createState() => _PageProfileTeacherState();
}

class _PageProfileTeacherState extends State<PageProfileTeacher> {
  String firstnameuser, lastnameuser, departmentuser;

  @override
  void initState() {
    findUser();
    if (mounted) {
      super.initState();
    }
  }

  void dispose() {
    super.dispose();
  }

  Future findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (this.mounted) {
      setState(() {
        firstnameuser = preferences.getString('firstname');
        lastnameuser = preferences.getString('lastname');
        departmentuser = preferences.getString('deparment');
      });
    }
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
                    SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          firstnameuser == null ? 'GUEST' : firstnameuser,
                          style: TextStyle(fontSize: 15.0),
                        ),
                        SizedBox(width: 15.0),
                        Text(
                          lastnameuser == null ? '' : lastnameuser,
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ],
                    ),
                    SizedBox(height: 3.0),
                    Text((departmentuser != null) ? departmentuser : ''),
                  ],
                ),
              ),
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
