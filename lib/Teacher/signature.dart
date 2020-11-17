import 'package:signature/signature.dart';
import 'package:flutter/material.dart';

class Signture extends StatefulWidget {
  Signture({Key key}) : super(key: key);

  @override
  _SigntureState createState() => _SigntureState();
}

class _SigntureState extends State<Signture> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
  );

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => print("Value changed"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ลายเซ็นผู้ปกครอง'),
        leading: iconBack(context),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.replay),
              onPressed: () {
                setState(() {
                  _controller.clear();
                });
              }),
          IconButton(icon: Icon(Icons.save), onPressed: () {}),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            child: Card(
              elevation: 10.0,
              child: Signature(
                controller: _controller,
                height: MediaQuery.of(context).size.height,
              ),
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
