import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:KABINBURI/style/connect_api.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

class ClicksPerYear {
  final String year;
  final int clicks;
  final charts.Color color;

  ClicksPerYear(this.year, this.clicks, Color color)
      : this.color = new charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}

class AdminT extends StatefulWidget {
  AdminT({Key key}) : super(key: key);

  @override
  _AdminTState createState() => _AdminTState();
}

class _AdminTState extends State<AdminT> {
  var style = TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold);
  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('dd-MM-yyyy');
  final String formatted = formatter.format(now);

  dynamic computer_n = 0;
  dynamic computer_v = 0;
  dynamic accounting_n = 0;
  dynamic accounting_v = 0;
  dynamic maintenance_n = 0;
  dynamic maintenance_v = 0;
  dynamic retail_n = 0;
  dynamic retail_v = 0;
  dynamic mechanic_n = 0;
  dynamic mechanic_v = 0;
  dynamic electrician_n = 0;
  dynamic electrician_v = 0;
  dynamic electronic_n = 0;
  dynamic electronic_v = 0;

  @override
  void initState() {
    super.initState();
    getdata();
  }

  Future getdata() async {
    var client = http.Client();
    var res = await client.post('$api/server/dashboard/admin');
    var result = json.decode(res.body);
    var status = result["status"];
    var results = result["result"];
    if (status) {
      setState(() {
        computer_n = results["computer_n"];
        computer_v = results["computer_v"];
        accounting_n = results["accounting_n"];
        accounting_v = results["accounting_v"];
        maintenance_n = results["maintenance_n"];
        maintenance_v = results["maintenance_v"];
        retail_n = results["retail_n"];
        retail_v = results["retail_v"];
        mechanic_n = results["mechanic_n"];
        mechanic_v = results["mechanic_v"];
        electrician_n = results["electrician_n"];
        electrician_v = results["electrician_v"];
        electronic_n = results["electronic_n"];
        electronic_v = results["electronic_v"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    dynamic device = MediaQuery.of(context);

    var datacom = [
      new ClicksPerYear('\n ยังไม่เยี่ยมบ้าน  \n\n  แผนกวิชาคอมพิวเตอร์ธุรกิจ',
          computer_n, Colors.grey),
      new ClicksPerYear('\n เยี่ยมบ้านเเล้ว  \n\n  แผนกวิชาคอมพิวเตอร์ธุรกิจ',
          computer_v, Colors.blue),
    ];

    var dataaccount = [
      new ClicksPerYear('\n ยังไม่เยี่ยมบ้าน  \n\n   แผนกวิชาการบัญชี',
          accounting_n, Colors.grey),
      new ClicksPerYear('\n เยี่ยมบ้านเเล้ว  \n\n   แผนกวิชาการบัญชี',
          accounting_v, Colors.blue),
    ];

    var datamaintenance = [
      new ClicksPerYear('\n ยังไม่เยี่ยมบ้าน  \n\n   แผนกวิชาช่างซ่อมบำรุง',
          maintenance_n, Colors.grey),
      new ClicksPerYear('\n เยี่ยมบ้านเเล้ว  \n\n   แผนกวิชาช่างซ่อมบำรุง',
          maintenance_v, Colors.blue),
    ];

    var dataretail = [
      new ClicksPerYear('\n ยังไม่เยี่ยมบ้าน  \n\n   แผนกวิชาธุรกิจค้าปลีก',
          retail_n, Colors.grey),
      new ClicksPerYear('\n เยี่ยมบ้านเเล้ว  \n\n   แผนกวิชาธุรกิจค้าปลีก',
          retail_v, Colors.blue),
    ];

    var datamechanic = [
      new ClicksPerYear('\n ยังไม่เยี่ยมบ้าน  \n\n   แผนกวิชาช่างยนต์',
          mechanic_n, Colors.grey),
      new ClicksPerYear('\n เยี่ยมบ้านเเล้ว  \n\n   แผนกวิชาช่างยนต์',
          mechanic_v, Colors.blue),
    ];

    var dataelectrician = [
      new ClicksPerYear('\n ยังไม่เยี่ยมบ้าน  \n\n   แผนกวิชาช่างไฟฟ้ากำลัง',
          electrician_n, Colors.grey),
      new ClicksPerYear('\n เยี่ยมบ้านเเล้ว  \n\n   แผนกวิชาช่างไฟฟ้ากำลัง',
          electrician_v, Colors.blue),
    ];

    var dataelectronic = [
      new ClicksPerYear(
          '\n ยังไม่เยี่ยมบ้าน  \n\n   แผนกวิชาช่างอิเล็กทรอนิกส์',
          electronic_n,
          Colors.grey),
      new ClicksPerYear('\n เยี่ยมบ้านเเล้ว  \n\n   แผนกวิชาช่างอิเล็กทรอนิกส์',
          electronic_v, Colors.blue),
    ];

    var seriescom = [
      new charts.Series(
        domainFn: (ClicksPerYear clickData, _) => clickData.year,
        measureFn: (ClicksPerYear clickData, _) => clickData.clicks,
        colorFn: (ClicksPerYear clickData, _) => clickData.color,
        id: 'Clicks',
        data: datacom,
      ),
    ];

    var seriesaccount = [
      new charts.Series(
        domainFn: (ClicksPerYear clickData, _) => clickData.year,
        measureFn: (ClicksPerYear clickData, _) => clickData.clicks,
        colorFn: (ClicksPerYear clickData, _) => clickData.color,
        id: 'Clicks',
        data: dataaccount,
      ),
    ];

    var seriesmaintenance = [
      new charts.Series(
        domainFn: (ClicksPerYear clickData, _) => clickData.year,
        measureFn: (ClicksPerYear clickData, _) => clickData.clicks,
        colorFn: (ClicksPerYear clickData, _) => clickData.color,
        id: 'Clicks',
        data: datamaintenance,
      ),
    ];

    var seriesretail = [
      new charts.Series(
        domainFn: (ClicksPerYear clickData, _) => clickData.year,
        measureFn: (ClicksPerYear clickData, _) => clickData.clicks,
        colorFn: (ClicksPerYear clickData, _) => clickData.color,
        id: 'Clicks',
        data: dataretail,
      ),
    ];

    var seriesmechanic = [
      new charts.Series(
        domainFn: (ClicksPerYear clickData, _) => clickData.year,
        measureFn: (ClicksPerYear clickData, _) => clickData.clicks,
        colorFn: (ClicksPerYear clickData, _) => clickData.color,
        id: 'Clicks',
        data: datamechanic,
      ),
    ];

    var serieselectrician = [
      new charts.Series(
        domainFn: (ClicksPerYear clickData, _) => clickData.year,
        measureFn: (ClicksPerYear clickData, _) => clickData.clicks,
        colorFn: (ClicksPerYear clickData, _) => clickData.color,
        id: 'Clicks',
        data: dataelectrician,
      ),
    ];

    var serieselectronic = [
      new charts.Series(
        domainFn: (ClicksPerYear clickData, _) => clickData.year,
        measureFn: (ClicksPerYear clickData, _) => clickData.clicks,
        colorFn: (ClicksPerYear clickData, _) => clickData.color,
        id: 'Clicks',
        data: dataelectronic,
      ),
    ];

    var chartcom = new charts.BarChart(
      seriescom,
      animate: true,
    );

    var chartaccount = new charts.BarChart(
      seriesaccount,
      animate: true,
    );

    var chartmaintenance = new charts.BarChart(
      seriesmaintenance,
      animate: true,
    );

    var chartretail = new charts.BarChart(
      seriesretail,
      animate: true,
    );

    var chartmechanic = new charts.BarChart(
      seriesmechanic,
      animate: true,
    );

    var chartelectrician = new charts.BarChart(
      serieselectrician,
      animate: true,
    );

    var chartelectronic = new charts.BarChart(
      serieselectronic,
      animate: true,
    );

    var chartWidgetcom = new Padding(
      padding: new EdgeInsets.all(32.0),
      child: Container(
        child: AspectRatio(
          aspectRatio: 100 / 100,
          child: new SizedBox(
            height: device.size.height / 1,
            child: chartcom,
          ),
        ),
      ),
    );

    var chartWidgetaccount = new Padding(
      padding: new EdgeInsets.all(32.0),
      child: Container(
        child: AspectRatio(
          aspectRatio: 100 / 100,
          child: new SizedBox(
            height: device.size.height / 1,
            child: chartaccount,
          ),
        ),
      ),
    );

    var chartWidgetmaintenance = new Padding(
      padding: new EdgeInsets.all(32.0),
      child: Container(
        child: AspectRatio(
          aspectRatio: 100 / 100,
          child: new SizedBox(
            height: device.size.height / 1,
            child: chartmaintenance,
          ),
        ),
      ),
    );

    var chartWidgetretail = new Padding(
      padding: new EdgeInsets.all(32.0),
      child: Container(
        child: AspectRatio(
          aspectRatio: 100 / 100,
          child: new SizedBox(
            height: device.size.height / 1,
            child: chartretail,
          ),
        ),
      ),
    );

    var chartWidgetmechanic = new Padding(
      padding: new EdgeInsets.all(32.0),
      child: Container(
        child: AspectRatio(
          aspectRatio: 100 / 100,
          child: new SizedBox(
            height: device.size.height / 1,
            child: chartmechanic,
          ),
        ),
      ),
    );

    var chartWidgetelectrician = new Padding(
      padding: new EdgeInsets.all(32.0),
      child: Container(
        child: AspectRatio(
          aspectRatio: 100 / 100,
          child: new SizedBox(
            height: device.size.height / 1,
            child: chartelectrician,
          ),
        ),
      ),
    );

    var chartWidgetelectronic = new Padding(
      padding: new EdgeInsets.all(32.0),
      child: Container(
        child: AspectRatio(
          aspectRatio: 100 / 100,
          child: new SizedBox(
            height: device.size.height / 1,
            child: chartelectronic,
          ),
        ),
      ),
    );

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 40),
        child: Center(
          child: Column(
            children: [
              Text(
                "ข้อมูลนักเรียน นักศึกษา ณ วันที่  $formatted",
                style: style,
              ),
              Expanded(
                child: new ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    chartWidgetcom,
                    chartWidgetaccount,
                    chartWidgetmaintenance,
                    chartWidgetretail,
                    chartWidgetmechanic,
                    chartWidgetelectrician,
                    chartWidgetelectronic,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
