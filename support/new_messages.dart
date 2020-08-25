import 'dart:convert';
import 'dart:io';

import 'package:KABINBURI/style/connect_api.dart';
import 'package:KABINBURI/style/contsan.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:http/http.dart' as http;

class AddNewMessages extends StatefulWidget {
  AddNewMessages({Key key}) : super(key: key);

  @override
  _AddNewMessagesState createState() => _AddNewMessagesState();
}

class _AddNewMessagesState extends State<AddNewMessages> {
  List<Asset> images = List<Asset>();
  File _image;

  Future getImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
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
                      // height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      height: 380.0,
                      margin: EdgeInsets.all(10.0),
                      child: (images).length == 0
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
                                loadAssets();
                              },
                            )
                          : showImages(),
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
    var client = http.Client();
    try {
      var _obj = {"data": "555"};
      print(_obj);
      var response = await client.post('$api/addmessages', body: _obj);
      var data = jsonDecode(response.body);
      print(data);
      print(data["status"]);
      var status = data["status"];
      if (status == true) {
        SweetAlert.show(context,
            title: " ",
            subtitle: "Svae Image Successfully",
            style: SweetAlertStyle.success);
      }
      return data;
    } finally {
      client.close();
    }
  }

  Widget showImages() {
    return ListView.builder(
      itemCount: (images).length,
      itemBuilder: (context, index) => Container(
        margin: EdgeInsets.all(10.0),
        child: AssetThumb(
          asset: images[index],
          width: 300,
          height: 300,
        ),
      ),
    );
  }

  Future loadAssets() async {
    List<Asset> resultList = List<Asset>();
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 1,
        enableCamera: false,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
      );
    } on Exception catch (e) {
      print(e.toString());
    }
    if (!mounted) return;
    setState(() {
      images = resultList;
    });
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
          if ((images).length > 0) {
            _uploadimages();
            Navigator.of(context).pop();
          } else {
            SweetAlert.show(
              context,
              subtitle: "กรุณาเลือกรูปภาพค่ะ...",
              style: SweetAlertStyle.confirm,
              showCancelButton: false,
            );
          }
        },
      ),
    );
  }
}
