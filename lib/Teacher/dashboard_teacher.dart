import 'dart:convert';
import 'package:KABINBURI/model/teacher_db_model.dart';
import 'package:KABINBURI/style/contsan.dart';
import 'package:http/http.dart' as http;
import 'package:KABINBURI/style/connect_api.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardT extends StatefulWidget {
  DashboardT({Key key}) : super(key: key);

  @override
  _DashboardTState createState() => _DashboardTState();
}

class _DashboardTState extends State<DashboardT> {
  var style = TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold);
  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('dd-MM-yyyy');
  final String formatted = formatter.format(now);
  var deparmentusers, deparmentIDusers;
  var amountvisit, amountnotvisit;
  bool isLoading = true;

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
      var _url = '$api/server/dashboard/dashboard-teacher';
      var _obj = {"deparmentid": (deparmentIDusers).toString()};
      var res = await client.post(_url, body: _obj);
      var result = json.decode(res.body);
      amountvisit = result["resultvisit"]["amountvisit"];
      amountnotvisit = result["resultnotvisit"]["amountnotvisit"];
      setState(() {
        isLoading = false;
        deparmentusers = deparmentuser;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading == true
          ? Center(child: progress())
          : Center(
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
                      height: 250.0,
                      child: SimpleBarChart.withSampleData(
                          amountnotvisit, amountvisit),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      child: Text(
                          'ข้อมูลนักเรียน นักศึกษา ณ วันที่  $formatted',
                          style: style),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 250,
                child: SimpleBarChart.withSampleData(null, null),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text('Bar Charts'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SimpleBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  SimpleBarChart(this.seriesList, {this.animate});
  factory SimpleBarChart.withSampleData(var notvisit, var visit) {
    return new SimpleBarChart(
      _createSampleData(visit, notvisit),
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
    );
  }

  static List<charts.Series<OrdinalSales, String>> _createSampleData(
      var avisit, var anvisit) {
    final data = [
      OrdinalSales(
          '\n  จำนวน $anvisit คน  \n\n ที่ยังไม่ไปเยี่ยมบ้าน', anvisit),
      OrdinalSales('\n  จำนวน $avisit คน  \n\n ไปเยี่ยมบ้านแล้ว', avisit),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}
