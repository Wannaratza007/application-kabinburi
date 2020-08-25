import 'package:KABINBURI/home_page/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

Future logout(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
  MaterialPageRoute route =
      new MaterialPageRoute(builder: (context) => LoginPage());
  Navigator.pushAndRemoveUntil(context, route, (route) => false);
}
