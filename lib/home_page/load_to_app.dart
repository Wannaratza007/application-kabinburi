import 'package:KABINBURI/home_page/login.dart';
import 'package:KABINBURI/style/contsan.dart';
import 'package:flutter/material.dart';

class LoadToAppPage extends StatefulWidget {
  LoadToAppPage({Key key}) : super(key: key);

  @override
  _LoadToAppPageState createState() => _LoadToAppPageState();
}

class _LoadToAppPageState extends State<LoadToAppPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(new Duration(milliseconds: 5000), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            progress(),
            Text('Loading...'),
          ],
        ),
      ),
    );
  }
}
