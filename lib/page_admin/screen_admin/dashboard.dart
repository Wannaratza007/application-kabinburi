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
    "https://scontent.fbkk2-8.fna.fbcdn.net/v/t1.0-9/85007490_3497405486999079_7082165706896179200_n.jpg?_nc_cat=102&_nc_sid=110474&_nc_eui2=AeGzwZAJQg0rDJ_kQDCPS80TQJfoMSqAiXBAl-gxKoCJcI_Rrk0FAC4evwrZTmDa8848gW4oS5zvfd7TxOWZuoMH&_nc_oc=AQlr0WdNY4aru5jsHJL1nye-px-AkJxnMEw4IJUw1WHExw_jJ-RcHHZSPWvxUhH5D5g&_nc_ht=scontent.fbkk2-8.fna&oh=738f8be94a35aa818ef4b98dcfa2904d&oe=5F047579 one",
    "https://scontent.fbkk2-7.fna.fbcdn.net/v/t1.0-9/87995869_3568528093220151_7988996125291970560_n.jpg?_nc_cat=106&_nc_sid=110474&_nc_eui2=AeHcvPLwQItYpvWuCUM8nmM2F46d77X8kxoXjp3vtfyTGuyVKlhB6V20vKJ7b0xi2ksEv2wTXPscCIO0-hoTHnHD&_nc_oc=AQnYgCfOTJ0suCpiRhlVCfQmFHTFY4Xw_GHtlvGG4FwPF0fq2zLM77gdqzdkwqoHpbU&_nc_ht=scontent.fbkk2-7.fna&oh=8acd5e0c9611ba31a2bce68a392096cf&oe=5F0444ED two",
    "https://scontent.fbkk2-7.fna.fbcdn.net/v/t1.0-9/91020337_3662750023797957_3230056392912011264_n.jpg?_nc_cat=108&_nc_sid=110474&_nc_eui2=AeH2mzPwRimDByPastpR_3BAh97tcjUiWLSH3u1yNSJYtDDyz4MVW46dXbeATB0bRu6ibkuP8LKwnqE49YkQ8Mwu&_nc_oc=AQlZ5Evkwc3RAUmC7EnOFBIGQCPUGOE6zKwXKyprzpp2aLlnuMz38Nfj_L1XtInif-s&_nc_ht=scontent.fbkk2-7.fna&oh=50efbe76bc9a14dda85b48ad4212f365&oe=5F03F386 three",
    "https://scontent.fbkk2-8.fna.fbcdn.net/v/t1.0-9/93825237_3731883583551267_4711030660683268096_n.jpg?_nc_cat=103&_nc_sid=110474&_nc_eui2=AeEZTLs3OpGmZnFfr-rdaLLmvt5mlHx8d0--3maUfHx3T2fE2El2_5X7U3sUtdbRXNaBmp222sJgGgI2kaOApMb0&_nc_oc=AQmdfVaUOUlCx1EK8ufZ7Ht3zYTMJPHwMQucD3rUkbqFHG_kd1197ynLgYOUg99HYYA&_nc_ht=scontent.fbkk2-8.fna&oh=277c40a1070eca7686ddb11b6fcb1e9b&oe=5F060F58 four",
    "https://scontent.fbkk2-5.fna.fbcdn.net/v/t1.0-9/92827225_3731887106884248_1109482475958042624_o.jpg?_nc_cat=110&_nc_sid=110474&_nc_eui2=AeHGQSu8KNHiP-7r83Fca86Xa1I8t_bKCBVrUjy39soIFZ3RozrbDuc_x6mKC7h3X5lax0Ll_KD3Jl_qkyRDeKgt&_nc_oc=AQmSFgo1HJzk50IwEvffpflVQ0hX1V259_3vxZC8VjnYabBvZ0Hytb1JWbdDB-lVN6E&_nc_ht=scontent.fbkk2-5.fna&oh=d5c5d72dda44fed852d6d95446709035&oe=5F0401EB five",
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
                        "title": "งานกิจกกรม",
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
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.circular(12.0),
              ),
              // child: CachedNetworkImage(
              //   progressIndicatorBuilder: (context, url, progress) =>
              //       CircularProgressIndicator(
              //     value: progress.progress,
              //   ),
              //   imageUrl: '',
              // ),

              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(10),
              //   image: DecorationImage(
              //     image: NetworkImage(imagesSlider[index]),
              //     fit: BoxFit.cover,
              //   ),
              // ),
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
