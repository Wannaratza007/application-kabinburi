import 'dart:convert';

import 'package:KABINBURI/style/connect_api.dart';
import 'package:image_picker/image_picker.dart';
import 'package:KABINBURI/style/contsan.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';

class NewMessagesPage extends StatefulWidget {
  NewMessagesPage({Key key}) : super(key: key);

  @override
  _NewMessagesPageState createState() => _NewMessagesPageState();
}

class _NewMessagesPageState extends State<NewMessagesPage> {
  File _image;
  var status;
  Future getImagegallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    print("mage.path :" + image.path);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'เพิ่มข่าวสาร',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Card(
              elevation: 5.0,
              child: Column(
                children: <Widget>[
                  Container(
                    child: Container(
                      height: 500.0,
                      margin: EdgeInsets.all(10.0),
                      child: _image == null
                          ? GestureDetector(
                              child: Container(
                                color: mainColor,
                                child: Center(
                                  child: Icon(
                                    Icons.add_photo_alternate,
                                    size: 80.0,
                                  ),
                                ),
                              ),
                              onTap: () {
                                getImagegallery();
                              },
                            )
                          : Image.file(_image),
                    ),
                  ),
                  buttonSVAE(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _uploadimages() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var client = http.Client();
    try {
      if (_image == null) return;
      String base64Image = base64Encode(_image.readAsBytesSync());
      String fileName = _image.path.split("/").last;
      var _obj = {
        "status": preferences.getString("status"),
        "image": base64Image,
        "name": fileName,
      };
      print(_obj);
      var response = await client.post('$api/addmessages', body: _obj);
      var data = jsonDecode(response.body);
      var status = data["status"];
      if (status == true) {
        new Future.delayed(new Duration(seconds: 2), () {
          SweetAlert.show(context,
              subtitle: "Svae Image Successfully",
              style: SweetAlertStyle.success);
        });
      } else {
        SweetAlert.show(
          context,
          subtitle: "เกิดข้อผิดพลาดกรูณาลองอีกครั้งค่ะ....",
          style: SweetAlertStyle.confirm,
          showCancelButton: false,
        );
      }
      return true;
    } finally {
      client.close();
    }
  }

  Widget buttonSVAE() {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(8.0),
      height: 60.0,
      child: RaisedButton(
        child: Text(
          'SVAE',
          style: TextStyle(
            fontSize: 24.0,
          ),
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        textColor: Colors.white,
        color: Colors.blue,
        onPressed: () {
          if (_image != null) {
            _uploadimages().then((res) => {
                  if (res == true) {Navigator.of(context).pop()}
                });
          } else {
            SweetAlert.show(
              context,
              subtitle: "กรุณาเลือกรูปภาพ",
              style: SweetAlertStyle.confirm,
              showCancelButton: false,
            );
          }
        },
      ),
    );
  }
}
