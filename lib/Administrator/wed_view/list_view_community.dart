import 'package:KABINBURI/style/contsan.dart';
import 'package:flutter/material.dart';

class ListViewCommunity extends StatefulWidget {
  ListViewCommunity({Key key}) : super(key: key);

  @override
  _ListViewCommunityState createState() => _ListViewCommunityState();
}

class _ListViewCommunityState extends State<ListViewCommunity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('งานกิจกรรม'),
      ),
    );
  }
}