import 'package:image_picker/image_picker.dart';
import 'package:KABINBURI/style/contsan.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AddNewMessages extends StatefulWidget {
  AddNewMessages({Key key}) : super(key: key);

  @override
  _AddNewMessagesState createState() => _AddNewMessagesState();
}

class _AddNewMessagesState extends State<AddNewMessages> {
  File _image;
  Future getImagegallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
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
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Card(
              elevation: 5.0,
              child: Column(
                children: <Widget>[
                  Container(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
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
        onPressed: () {},
      ),
    );
  }
}
