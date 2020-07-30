import 'package:webview_flutter/webview_flutter.dart';
import 'package:KABINBURI/style/contsan.dart';
import 'package:flutter/material.dart';

class PageWebView extends StatefulWidget {
  PageWebView({Key key, String arguments}) : super(key: key);

  @override
  _PageWebViewState createState() => _PageWebViewState();
}

class _PageWebViewState extends State<PageWebView> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> weblink = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(
          title: Text(weblink["title"]),
          leading: IconButton(
            color: Colors.black,
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: WebView(
          initialUrl: weblink["url"],
        ));
  }
}
