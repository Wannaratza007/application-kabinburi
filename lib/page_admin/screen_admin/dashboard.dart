import 'dart:convert';
import 'package:KABINBURI/models/community_model.dart';
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
    "https://4.bp.blogspot.com/-eV7KFWYOhgM/UMw4AOJb79I/AAAAAAAAACQ/4Dtc5yqY32Y/w1200-h630-p-k-no-nu/DSC06567.JPG",
    "https://scontent.fbkk5-3.fna.fbcdn.net/v/t1.0-9/114218776_273508990603681_1479752560853370431_o.jpg?_nc_cat=111&_nc_sid=0be424&_nc_eui2=AeELqNeYLGPhOkqsacwgUERa0sFPARmOVwLSwU8BGY5XAq2IdYZ2R_iM8X6KcTp5rhHrSSLPrSmhv-_gVkcIzZlJ&_nc_ohc=709V2zLWxmgAX8PQXXS&_nc_ht=scontent.fbkk5-3.fna&oh=bc47e3c6beb7babb58bdea76e6903dd0&oe=5F417860",
    "https://scontent.fbkk5-5.fna.fbcdn.net/v/t1.0-9/116696662_276896856931561_9068128738272014893_o.jpg?_nc_cat=104&_nc_sid=0be424&_nc_eui2=AeE0DH8eDa8c1cBJNnwvBYXHgMhyQHtysGWAyHJAe3KwZcGr-zETeiKugqIWhyyOVKJvMLvvuSEn2tyr_tWqUiy0&_nc_ohc=1WAGz6pvuSUAX-cWNkF&_nc_ht=scontent.fbkk5-5.fna&oh=928a9a025feb54bfee914b11dda7192d&oe=5F482FAD",
    "https://scontent.fbkk5-5.fna.fbcdn.net/v/t1.0-9/116637131_276950443592869_1220570832513759601_o.jpg?_nc_cat=104&_nc_sid=e007fa&_nc_eui2=AeEz0YE8wAs7EZzdKVMqFG06Kn4ze2ktuQ8qfjN7aS25D6naBA-hKoxHpbyxvD2S0cg0M-VZ-_mNJjIJmzUZUsxh&_nc_ohc=Zr1MCiSyJpoAX9XEdTe&_nc_ht=scontent.fbkk5-5.fna&oh=d6fce7642f2b961a6c389124f03805e0&oe=5F469DF5",
    // "https://scontent.fbkk5-3.fna.fbcdn.net/v/t1.0-9/114218776_273508990603681_1479752560853370431_o.jpg?_nc_cat=111&_nc_sid=0be424&_nc_eui2=AeELqNeYLGPhOkqsacwgUERa0sFPARmOVwLSwU8BGY5XAq2IdYZ2R_iM8X6KcTp5rhHrSSLPrSmhv-_gVkcIzZlJ&_nc_ohc=709V2zLWxmgAX8PQXXS&_nc_ht=scontent.fbkk5-3.fna&oh=bc47e3c6beb7babb58bdea76e6903dd0&oe=5F417860",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            sliderImage(),
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
                        CircularProgressIndicator(
                      value: progress.progress,
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
                        CircularProgressIndicator(
                      value: progress.progress,
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
        itemCount: imagesSlider.length,
        options: CarouselOptions(
          autoPlay: true,
          aspectRatio: 2.0,
          enlargeCenterPage: true,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Container(
              // decoration: BoxDecoration(
              //   color: mainColor,
              //   borderRadius: BorderRadius.circular(12.0),
              // ),
              // child: CachedNetworkImage(
              //   progressIndicatorBuilder: (context, url, progress) =>
              //       CircularProgressIndicator(
              //     value: progress.progress,
              //   ),
              //   imageUrl: '',
              // ),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 3.0, color: Colors.grey),
                image: DecorationImage(
                  image: NetworkImage(imagesSlider[index]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            onTap: () {},
          );
        },
      ),
    );
  }

  Future<void> apiListmessages() async {
    var client = http.Client();
    try {
      var response = await client.post('$api/messages');
      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(response.body);
        List<dynamic> data = map["result"];
        for (var mapdata in data) {
          setState(() {
            MessagesModel _listMessage = MessagesModel.fromJson(mapdata);
            _listMessages.add(_listMessage);
          });
        }
        return data;
      } else {}
    } finally {
      client.close();
    }
  }

  Future<void> apiListcommunitys() async {
    var client = http.Client();
    try {
      var response = await client.post('$api/community');
      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(response.body);
        dynamic data = map["result"];
        for (var mapdata in data) {
          setState(() {
            CommunityModel _listCommunity = CommunityModel.fromJson(mapdata);
            _listCommunitys.add(_listCommunity);
          });
        }
        return data;
      } else {}
    } finally {
      client.close();
    }
  }
}
