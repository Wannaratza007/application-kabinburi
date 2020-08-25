import 'dart:convert';
import 'package:KABINBURI/models/community_model.dart';
import 'package:KABINBURI/models/imagesSlider_model.dart';
import 'package:KABINBURI/page_admin/screen_admin/wed_view/list_view_community.dart';
import 'package:KABINBURI/page_admin/screen_admin/wed_view/list_view_messages.dart';
import 'package:KABINBURI/page_admin/screen_admin/wed_view/wed_view.dart';
import 'package:http/http.dart' as http;
import 'package:KABINBURI/models/message_model.dart';
import 'package:KABINBURI/style/connect_api.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:KABINBURI/style/contsan.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<MessagesModel> _listMessages = List();
  List<CommunityModel> _listCommunitys = List();

  @override
  void initState() {
    apiListcommunitys();
    apiListmessages();
    super.initState();
  }

  final List<String> imagesSlider = [
    "https://scontent.fbkk5-3.fna.fbcdn.net/v/t1.0-9/116716203_281604803127433_6873937324063089041_o.jpg?_nc_cat=111&_nc_sid=e007fa&_nc_eui2=AeGhm0WJSkKy8DfYKeaf-GAsb_drZhyfmS5v92tmHJ-ZLq4UUg1c4EQz0jMDG2pHqgk84NAi1Q4VY4re8w2q8VKt&_nc_ohc=y4tWfKAbXZcAX_duUJJ&_nc_ht=scontent.fbkk5-3.fna&oh=969e3d3e7d8c29e40ab4c72dd53582d4&oe=5F4FCF21",
    "https://scontent.fbkk5-3.fna.fbcdn.net/v/t1.0-9/114218776_273508990603681_1479752560853370431_o.jpg?_nc_cat=111&_nc_sid=0be424&_nc_eui2=AeELqNeYLGPhOkqsacwgUERa0sFPARmOVwLSwU8BGY5XAq2IdYZ2R_iM8X6KcTp5rhHrSSLPrSmhv-_gVkcIzZlJ&_nc_ohc=wBHSpEKcukQAX97xflV&_nc_ht=scontent.fbkk5-3.fna&oh=be9aba7a79d70c740b8906fee07c71f7&oe=5F514A60",
    "https://scontent.fbkk5-5.fna.fbcdn.net/v/t1.0-9/116696662_276896856931561_9068128738272014893_o.jpg?_nc_cat=104&_nc_sid=0be424&_nc_eui2=AeE0DH8eDa8c1cBJNnwvBYXHgMhyQHtysGWAyHJAe3KwZcGr-zETeiKugqIWhyyOVKJvMLvvuSEn2tyr_tWqUiy0&_nc_ohc=wG5pFM3CEOAAX-UOVGC&_nc_ht=scontent.fbkk5-5.fna&oh=72517f575f2cf19204f52b36bee8b3cb&oe=5F5018AD",
    "https://scontent.fbkk5-5.fna.fbcdn.net/v/t1.0-9/116637131_276950443592869_1220570832513759601_o.jpg?_nc_cat=104&_nc_sid=e007fa&_nc_eui2=AeEz0YE8wAs7EZzdKVMqFG06Kn4ze2ktuQ8qfjN7aS25D6naBA-hKoxHpbyxvD2S0cg0M-VZ-_mNJjIJmzUZUsxh&_nc_ohc=iWA4h5KfWNgAX_ctcVm&_nc_ht=scontent.fbkk5-5.fna&oh=4a68d058abfb72d98b46f83aff701cdf&oe=5F527B75",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            imagesSlider.length == 0 ? progress() : sliderImage(),
            textlist(context, 'ข่าวสาร', ListViewMessages()),
            _listMessages.length == 0 ? progress() : messagesSlider(),
            textlist(context, 'กิจกรรม', ListViewCommunity()),
            _listCommunitys.length == 0 ? progress() : showCommunity()
          ],
        ),
      ),
    );
  }

  Widget messagesSlider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      height: 230.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _listMessages.length,
        itemBuilder: (context, index) {
          return Container(
            child: GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                margin: EdgeInsets.only(left: 10.0, right: 10.0),
                width: 330.0,
                child: Container(
                  child: CachedNetworkImage(
                    progressIndicatorBuilder: (context, url, progress) =>
                        Container(
                      padding: EdgeInsets.all(12.0),
                      child: CircularProgressIndicator(
                        value: progress.progress,
                      ),
                    ),
                    imageUrl: _listMessages[index].urlImages,
                  ),
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(10),
                  //   image: DecorationImage(
                  //     image: NetworkImage(imagesVal),
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PageWebView(),
                    settings: RouteSettings(
                      arguments: {
                        "title": "ข่าวสาร",
                        "url": _listMessages[index].link
                      },
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget showCommunity() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      height: 230.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _listCommunitys.length,
        itemBuilder: (context, index) => Container(
          child: GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: mainColor,
              ),
              margin: EdgeInsets.only(left: 10.0, right: 10.0),
              width: 200.0,
              child: Column(
                children: <Widget>[
                  CachedNetworkImage(
                    progressIndicatorBuilder: (context, url, progress) =>
                        Container(
                      padding: EdgeInsets.all(10.0),
                      child: CircularProgressIndicator(
                        value: progress.progress,
                      ),
                    ),
                    imageUrl: _listCommunitys[index].urlimages,
                  ),
                  ListTile(
                    title: Text(
                      _listCommunitys[index].title,
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PageWebView(),
                  settings: RouteSettings(
                    arguments: {
                      "title": _listCommunitys[index].title,
                      "url": _listCommunitys[index].link
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget imagesCommunity(
      String imagesVal, String header, String subheader, String url) {
    return Container(
      child: GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: mainColor,
          ),
          margin: EdgeInsets.only(left: 10.0, right: 10.0),
          width: 200.0,
          child: Column(
            children: <Widget>[
              CachedNetworkImage(
                progressIndicatorBuilder: (context, url, progress) =>
                    CircularProgressIndicator(
                  value: progress.progress,
                ),
                imageUrl: imagesVal,
              ),
              ListTile(
                  title: Text(
                    header,
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(subheader)),
            ],
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PageWebView(),
              settings: RouteSettings(
                arguments: {"title": header, "url": url},
              ),
            ),
          );
        },
      ),
    );
  }

  Widget textlist(BuildContext context, String text, Widget page) {
    return Container(
      padding: EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 0.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                text,
                style: TextStyle(
                  letterSpacing: 1.5,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.black,
                  fontFamily: 'KanitItalic',
                ),
              ),
              // GestureDetector(
              //   child: Text(
              //     'ดูทั้งหมด',
              //     style: TextStyle(
              //         fontSize: 16.0,
              //         color: Colors.blue[400],
              //         fontWeight: FontWeight.w600,
              //         letterSpacing: 1.0),
              //   ),
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => page),
              //     );
              //   },
              // ),
            ],
          ),
        ],
      ),
    );
  }

  Widget sliderImage() {
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      child: CarouselSlider.builder(
        itemCount: (imagesSlider).length,
        options: CarouselOptions(
          autoPlay: true,
          aspectRatio: 2.0,
          enlargeCenterPage: true,
        ),
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 3.0, color: Colors.grey),
            image: DecorationImage(
              image: NetworkImage(imagesSlider[index]),
              fit: BoxFit.cover,
            ),
          ),
          // child: CachedNetworkImage(
          //   progressIndicatorBuilder: (context, url, progress) =>
          //       CircularProgressIndicator(
          //     value: progress.progress,
          //   ),
          //   imageUrl: _listSlider[index].linkImages,
          // ),
        ),
      ),
    );
  }

  Future apiListmessages() async {
    var client = http.Client();
    try {
      var response = await client.post('$api/messages');
      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(response.body);
        List<dynamic> data = map["result"];
        for (var i in data) {
          setState(() {
            MessagesModel _listMessage = MessagesModel.fromJson(i);
            _listMessages.add(_listMessage);
          });
        }
        return data;
      } else {}
    } finally {
      client.close();
    }
  }

  Future apiListcommunitys() async {
    var client = http.Client();
    try {
      var response = await client.post('$api/community');
      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(response.body);
        dynamic data = map["result"];
        for (var i in data) {
          setState(() {
            CommunityModel _listCommunity = CommunityModel.fromJson(i);
            _listCommunitys.add(_listCommunity);
          });
        }
        return data;
      } else {}
    } finally {
      client.close();
    }
  }

  // Future apiListimagesSlider() async {
  //   var client = http.Client();
  //   try {
  //     var response = await client.post('$api/showimage');
  //     if (response.statusCode == 200) {
  //       Map<String, dynamic> map = json.decode(response.body);
  //       List<dynamic> data = map["result"];
  //       for (var i in data) {
  //         setState(() {
  //           ImagesSlider _list = ImagesSlider.fromJson(i);
  //           _listSlider.add(_list);
  //         });
  //       }
  //       return data;
  //     } else {}
  //   } finally {
  //     client.close();
  //   }
  // }
}
