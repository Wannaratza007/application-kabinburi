import 'package:KABINBURI/Administrator/main_admin.dart';
import 'package:KABINBURI/Teacher/main_Teacher.dart';
import 'package:KABINBURI/sign_in.dart';
import 'package:KABINBURI/style/singout.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadAppPage extends StatefulWidget {
  LoadAppPage({Key key}) : super(key: key);

  @override
  _LoadAppPageState createState() => _LoadAppPageState();
}

class _LoadAppPageState extends State<LoadAppPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(new Duration(milliseconds: 1500), () {
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
          pushRemove(context, MainAdminPage());
        } else if (status == 'teacher') {
          pushRemove(context, MainTeacherPage());
        } else if (status == 'user') {
          // pushRemove(context, MainUsersPage());
        }
      } else {
        pushRemove(context, SignInPage());
      }
    } catch (e) {
      print(e.toString());
    }
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
                  fontFamily: 'Mali',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
