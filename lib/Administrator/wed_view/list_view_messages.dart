import 'package:KABINBURI/style/contsan.dart';
import 'package:flutter/material.dart';

class ListViewMessages extends StatefulWidget {
  ListViewMessages({Key key}) : super(key: key);

  @override
  _ListViewMessagesState createState() => _ListViewMessagesState();
}

class _ListViewMessagesState extends State<ListViewMessages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('ข่าวสาร'),
      ),
    );
  }
}