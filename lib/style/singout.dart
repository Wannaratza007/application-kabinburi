import 'package:KABINBURI/home_page/load_to_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

Future logout(BuildContext context) async {
  var prefs = await SharedPreferences.getInstance();
  prefs.clear();
  var route = MaterialPageRoute(builder: (context) => LoadToAppPage());
  Navigator.pushAndRemoveUntil(context, route, (route) => false);
  // Future.delayed(const Duration(milliseconds: 500), () {
  //   SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  // });
}

// ignore: missing_return
Future pushRemove(BuildContext context, Widget page) {
  MaterialPageRoute pageroute = MaterialPageRoute(builder: (context) => page);
  Navigator.pushAndRemoveUntil(context, pageroute, (route) => false);
}
