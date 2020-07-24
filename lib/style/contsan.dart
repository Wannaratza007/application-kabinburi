import 'package:flutter/material.dart';

var primaryColor = Colors.blue[700];
var indexColor = Colors.lightBlue[600];
var currentIndexColor = Colors.red[600];
var mainColor = Colors.grey[300];

Widget progress() {
  return Container(
    margin: EdgeInsets.only(top: 30.0, bottom: 15.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: CircularProgressIndicator(),
        ),
        Container(
          margin: EdgeInsets.only(top: 15.0),
          child: Text('กำลังโหลดข้อมูล....'),
        ),
      ],
    ),
  );
}

var testlist = TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500);
var testlistsub = TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400);

final kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xFF6CA8F1),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);
