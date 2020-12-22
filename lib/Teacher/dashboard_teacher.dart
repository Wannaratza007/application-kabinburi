import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:KABINBURI/style/connect_api.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClicksPerYear {
  final String year;
  final int clicks;
  final charts.Color color;

  ClicksPerYear(this.year, this.clicks, Color color)
      : this.color = new charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}

class DashboardT extends StatefulWidget {
  DashboardT({Key key}) : super(key: key);

  @override
  _DashboardTState createState() => _DashboardTState();
}

class _DashboardTState extends State<DashboardT> {
  var style = TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold);
  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('dd/MM/yyyy');
  final String formatted = formatter.format(now);
  var deparmentusers;
  dynamic visit = 0;
  dynamic notvisit = 0;

  @override
  void initState() {
    super.initState();
    getDeparment();
  }

  Future getDeparment() async {
    if (this.mounted) {
      var client = http.Client();
      var preferences = await SharedPreferences.getInstance();
      var deparmentuser = preferences.getString('deparment');
      var deparmentIDusers = preferences.getInt('deparmentID');
      var _url = '$api/server/dashboard/teacher';
      var _obj = {"deparmentid": (deparmentIDusers).toString()};
      var res = await client.post(_url, body: _obj);
      var result = json.decode(res.body);
      var data = result["result"];
      setState(() {
        visit = data["visit"];
        notvisit = data["notvisit"];
        deparmentusers = deparmentuser;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    dynamic device = MediaQuery.of(context);

    var data = [
      new ClicksPerYear('\n  จำนวน $notvisit คน \n\n  ยังไม่เยี่ยมบ้าน',
          notvisit, Colors.red[400]),
      new ClicksPerYear('\n  จำนวน $visit คน  \n\n  เยี่ยมบ้านเเล้ว', visit,
          Colors.green[400]),
    ];

    var series = [
      new charts.Series(
        domainFn: (ClicksPerYear clickData, _) => clickData.year,
        measureFn: (ClicksPerYear clickData, _) => clickData.clicks,
        colorFn: (ClicksPerYear clickData, _) => clickData.color,
        id: 'Clicks',
        data: data,
      ),
    ];

    var chart = new charts.BarChart(
      series,
      animate: true,
    );

    var chartWidget = new Padding(
      padding: new EdgeInsets.all(32.0),
      child: Container(
        child: AspectRatio(
          aspectRatio: 100 / 100,
          child: new SizedBox(
            height: device.size.height / 1,
            child: chart,
          ),
        ),
      ),
    );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                child: Text("ข้อมูลนักเรียน นักศึกษา  $deparmentusers",
                    style: style),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                child: chartWidget,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                child: Text('ข้อมูลนักเรียน นักศึกษา ณ วันที่  $formatted',
                    style: style),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
