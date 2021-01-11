import 'dart:convert';
import 'package:KABINBURI/style/contsan.dart';
import 'package:http/http.dart' as http;
import 'package:KABINBURI/style/connect_api.dart';
import 'package:signature/signature.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Signture extends StatefulWidget {
  String nameGD;
  int stdID;
  Signture({Key key, this.nameGD, this.stdID}) : super(key: key);

  @override
  _SigntureState createState() => _SigntureState();
}

class _SigntureState extends State<Signture> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => print("Value changed"));
  }

  Future uploadSignature(var data) async {
    try {
      var imageBase64 = {
        "name": 'SignatureDispatch.jpg',
        "image": data,
        "idSTD": widget.stdID,
      };
      String url = "$api/server/student/signature";
      String _obj = jsonEncode(imageBase64);
      final response = await http.post(url,
          headers: {
            'content-type': 'application/json',
          },
          body: _obj);
      var res = json.decode(response.body);
      if (res["status"]) {
        print('Succes');
        setState(() {
          Navigator.pop(context, true);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ลายเซ็น ' + widget.nameGD, style: hintStyle),
        leading: iconBack(context),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.replay),
              onPressed: () {
                setState(() {
                  _controller.clear();
                });
              }),
          SizedBox(width: 10.0),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () async {
              if (_controller.isNotEmpty) {
                var data = await _controller.toPngBytes();
                uploadSignature(data);
              }
            },
          ),
          SizedBox(width: 15.0),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Signature(
              controller: _controller,
              height: MediaQuery.of(context).size.height,
              // height: MediaQuery.of(context).size.height *1/3,
              backgroundColor: Colors.lightBlueAccent,
            ),
          ),
        ],
      ),
    );
  }

  Widget iconBack(BuildContext context) {
    return IconButton(
      color: Colors.black,
      icon: Icon(Icons.arrow_back_ios, color: Colors.white),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}
