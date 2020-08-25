import 'package:KABINBURI/home_page/login.dart';
import 'package:KABINBURI/page_admin/main_admin.dart';
import 'package:KABINBURI/page_teacher/main_teacher.dart';
import 'package:KABINBURI/page_user/main_user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';

class LoadToAppPage extends StatefulWidget {
  LoadToAppPage({Key key}) : super(key: key);

  @override
  _LoadToAppPageState createState() => _LoadToAppPageState();
}

class _LoadToAppPageState extends State<LoadToAppPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(new Duration(seconds: 4), () {
      checkpreferences();
    });
  }

  Future checkpreferences() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String status = preferences.getString('status');
      print('status  $status');
      if (status != null && status.isNotEmpty) {
        if (status == 'admin') {
          routepage(MainAdminPage());
        } else if (status == 'teacher') {
          routepage(MainTeacherPass());
        } else if (status == 'user') {
          routepage(MainUsersPage());
        } else {
          SweetAlert.show(context,
              subtitle: "Error: Unknown status!", style: SweetAlertStyle.error);
        }
      } else {
        routepage(LoginPage());
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void routepage(pages) {
    MaterialPageRoute routesGoToPage =
        MaterialPageRoute(builder: (context) => pages);
    Navigator.pushAndRemoveUntil(context, routesGoToPage, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(30.0),
              child: Image.asset('assets/images/KABINBURI.png'),
            ),
            Container(
              child: Text(
                'By Bussiness Computer',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
