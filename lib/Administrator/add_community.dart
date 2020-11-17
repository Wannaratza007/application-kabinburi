import 'dart:convert';
import 'package:KABINBURI/page_admin/main_admin.dart';
import 'package:KABINBURI/style/connect_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sweetalert/sweetalert.dart';

class NewCommunotyPage extends StatefulWidget {
  NewCommunotyPage({Key key}) : super(key: key);

  @override
  _NewCommunotyPageState createState() => _NewCommunotyPageState();
}

class _NewCommunotyPageState extends State<NewCommunotyPage> {
  TextEditingController imageShowTitle = TextEditingController();
  TextEditingController textTitle = TextEditingController();
  TextEditingController imageGoogle = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future apiAddCommunity(imageShowTitle, textTitle, imageGoogle) async {
    var client = http.Client();
    try {
      var _obj = {
        "urlimages": imageShowTitle,
        "link": imageGoogle,
        "title": textTitle
      };
      var response = await client.post('$api/addcommunity', body: _obj);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        if (data['status'] == true) {
          SweetAlert.show(context,
              subtitle: "บันทึกข้อมูลสำเร็จ", style: SweetAlertStyle.success);
          Future.delayed(new Duration(milliseconds: 800), () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainAdminPage()),
            );
          });
        }
      } else {
        throw Exception('Failed to load data');
      }
    } finally {
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('เพิ่มข้อมูลกิจกกรม', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        leading: iconBack(context),
        actions: <Widget>[saveCommunity()],
      ),
      body: Form(
        key: _formKey,
        child: Container(
          child: ListView(
            children: <Widget>[
              titleText('URL Images Title'),
              input(imageShowTitle, 'กรุณากรอกขู้อมูล'),
              titleText('Title Text'),
              input(textTitle, 'กรุณากรอกขู้อมูล'),
              titleText('URL Google Drive'),
              input(imageGoogle, 'กรุณากรอกขู้อมูล'),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconBack(BuildContext context) {
    return IconButton(
      color: Colors.black,
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  Widget saveCommunity() {
    return Padding(
      padding: EdgeInsets.only(right: 20.0),
      child: GestureDetector(
        child: IconButton(
          icon: Icon(
            Icons.save,
            color: Colors.black,
            size: 32.0,
          ),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              apiAddCommunity(imageShowTitle.text.trim(), textTitle.text.trim(),
                  imageGoogle.text.trim());
            }
          },
        ),
      ),
    );
  }

  Widget titleText(String text) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 10.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget input(TextEditingController controller, String isEmpty) {
    return Container(
      padding: EdgeInsets.only(left: 20.0, right: 20.0),
      child: TextFormField(
        controller: controller,
        style: TextStyle(fontSize: 18.0),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return isEmpty;
          }
          return null;
        },
      ),
    );
  }
}
