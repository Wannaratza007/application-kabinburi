import 'package:KABINBURI/style/contsan.dart';
import 'package:flutter/material.dart';

class TimeLearn extends StatefulWidget {
  TimeLearn({Key key}) : super(key: key);

  @override
  _TimeLearnState createState() => _TimeLearnState();
}

class _TimeLearnState extends State<TimeLearn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: <Widget>[
            Container(
              color: primaryColor,
              constraints: BoxConstraints.expand(height: 50),
               child: TabBar(
                 indicatorColor: Colors.white,
                 labelStyle: TextStyle(fontSize: 18.0),
                 indicatorWeight: 3,
                 tabs: [
                Tab(text: 'ปวช.'),
                Tab(text: 'ปวส.'),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
