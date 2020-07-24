import 'package:KABINBURI/home_page/load_to_app.dart';
import 'package:KABINBURI/style/contsan.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: primaryColor, cursorColor: indexColor),
      title: 'KABINBURI',
      home: LoadToAppPage(),
    );
  }
}
