import 'package:flutter/material.dart';

class HelpAddress extends StatelessWidget {
  const HelpAddress({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'ศูนย์ช่วยเหลือ',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            name(),
            title('ที่ตั้ง'),
            textsud(
                '202 หมู่ 3 ต.ลาดตะเคียน ตำบลลาดตะเคียน อำเภอกบินทร์บุรี ปราจีนบุรี 25110',
                context),
            title('ติดต่อ'),
            textsud(
                'เบอร์โทรศัพท์: 037 625 220  FACEBOOK: วิทยาลัยการอาชีพกบินทร์บุรี',
                context),
          ],
        ),
      ),
    );
  }

  Widget textsud(String text, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(left: 18.0, top: 8.0, right: 5.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 15.0),
      ),
    );
  }

  Widget title(String text) {
    return Container(
      margin: EdgeInsets.only(left: 10.0, top: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget name() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            'วิทยาลัยการอาชีพกบินทร์บุรี',
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }
}
