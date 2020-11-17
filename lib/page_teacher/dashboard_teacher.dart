import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardTeacher extends StatefulWidget {
  DashboardTeacher({Key key}) : super(key: key);

  @override
  _DashboardTeacherState createState() => _DashboardTeacherState();
}

class _DashboardTeacherState extends State<DashboardTeacher> {
  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('HH:mm dd-MM-yyyy');
  final String formatted = formatter.format(now);
  String deparmentusers;

  @override
  void initState() {
    super.initState();
    getDeparment();
  }

  Future getDeparment() async {
    var preferences = await SharedPreferences.getInstance();
    var deparmentuser = preferences.getString('deparment');
    setState(() {
      deparmentusers = deparmentuser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                child: Text("ข้อมูลนักเรียน นักศึกษา  $deparmentusers"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 250.0,
                child: SimpleBarChart.withSampleData(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                child: Text('ข้อมูลนักเรียน นักศึกษา ณ วันที่  $formatted'),
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
                child: SimpleBarChart.withSampleData(),
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
  factory SimpleBarChart.withSampleData() {
    return new SimpleBarChart(
      _createSampleData(),
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

  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final data = [
      new OrdinalSales('ที่ยังไม่ไปเยี่ยมบ้าน', 5),
      new OrdinalSales('ไปเยี่ยมบ้านแล้ว', 25),
      // new OrdinalSales('2016', 100),
      // new OrdinalSales('2017', 75),
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
