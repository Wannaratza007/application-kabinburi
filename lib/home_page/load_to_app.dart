import 'package:KABINBURI/home_page/login.dart';
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
    Future.delayed(new Duration(seconds: 5), () {
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
