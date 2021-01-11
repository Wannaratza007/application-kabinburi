import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Color primaryColor = Colors.blue[700];
Color indexColor = Colors.lightBlue[600];
Color mainColor = Colors.grey[300];

// ignore: missing_return
Future hidekeyboard() {
  SystemChannels.textInput.invokeMethod('TextInput.hide');
}

Widget textAppBar() {
  return Center(
    child: Text(
      'KABINBURI',
      style: TextStyle(
        fontSize: 33.0,
        fontWeight: FontWeight.w500,
        fontFamily: 'MitrSemiBold',
      ),
    ),
  );
}

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

Widget notedata() {
  return Center(
    child: Container(
      child: Text(
        'ไม่พบข้อมูล',
        style: TextStyle(
            fontSize: 50.0,
            fontWeight: FontWeight.w900,
            color: mainColor,
            fontFamily: 'Mali'),
      ),
    ),
  );
}

var textlist =
    TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500, fontFamily: 'Mali');
var textlistsub =
    TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400, fontFamily: 'Mali');

var style =
    TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, fontFamily: 'Mali');

var hintStyle = TextStyle(fontFamily: 'Mali');

final kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'Mali',
);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'Mali',
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
