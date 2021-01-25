import 'dart:convert';
import 'package:KABINBURI/style/contsan.dart';
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
  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('dd-MM-yyyy');
  final String formatted = formatter.format(now);

  // ignore: non_constant_identifier_names
  dynamic computer_n = 0;
  // ignore: non_constant_identifier_names
  dynamic computer_v = 0;
  // ignore: non_constant_identifier_names
  dynamic accounting_n = 0;
  // ignore: non_constant_identifier_names
  dynamic accounting_v = 0;
  // ignore: non_constant_identifier_names
  dynamic maintenance_n = 0;
  // ignore: non_constant_identifier_names
  dynamic maintenance_v = 0;
  // ignore: non_constant_identifier_names
  dynamic retail_n = 0;
  // ignore: non_constant_identifier_names
  dynamic retail_v = 0;
  // ignore: non_constant_identifier_names
  dynamic mechanic_n = 0;
  // ignore: non_constant_identifier_names
  dynamic mechanic_v = 0;
  // ignore: non_constant_identifier_names
  dynamic electrician_n = 0;
  // ignore: non_constant_identifier_names
  dynamic electrician_v = 0;
  // ignore: non_constant_identifier_names
  dynamic electronic_n = 0;
  // ignore: non_constant_identifier_names
  dynamic electronic_v = 0;

  @override
  void initState() {
    super.initState();
    getdata();
  }

  Future getdata() async {
    var res = await http.post(
      '$api/server/dashboard/admin',
      headers: {
        'content-type': 'application/json',
      },
    );
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
      new ClicksPerYear(
          '\n  คอมพิวเตอร์ธุรกิจ \n\n จำนวน $computer_n คน \n\n ยังไม่เยี่ยมบ้าน',
          computer_n,
          Colors.grey),
      new ClicksPerYear(
          '\n  คอมพิวเตอร์ธุรกิจ \n\n จำนวน $computer_v คน \n\n  เยี่ยมบ้านเเล้ว',
          computer_v,
          Colors.blue),
    ];

    var dataaccount = [
      new ClicksPerYear(
          '\n  การบัญชี \n\n จำนวน $accounting_n คน \n\n ยังไม่เยี่ยมบ้าน',
          accounting_n,
          Colors.grey),
      new ClicksPerYear(
          '\n  การบัญชี \n\n จำนวน $accounting_v คน \n\n  เยี่ยมบ้านเเล้ว',
          accounting_v,
          Colors.blue),
    ];

    var datamaintenance = [
      new ClicksPerYear(
          '\n  ช่างซ่อมบำรุง \n\n จำนวน $maintenance_n คน \n\n ยังไม่เยี่ยมบ้าน',
          maintenance_n,
          Colors.grey),
      new ClicksPerYear(
          '\n  ช่างซ่อมบำรุง \n\n จำนวน $maintenance_v คน \n\n  เยี่ยมบ้านเเล้ว',
          maintenance_v,
          Colors.blue),
    ];

    var dataretail = [
      new ClicksPerYear(
          '\n  ธุรกิจค้าปลีก \n\n จำนวน $retail_n คน \n\n ยังไม่เยี่ยมบ้าน',
          retail_n,
          Colors.grey),
      new ClicksPerYear(
          '\n  ธุรกิจค้าปลีก \n\n จำนวน $retail_v คน \n\n  เยี่ยมบ้านเเล้ว',
          retail_v,
          Colors.blue),
    ];

    var datamechanic = [
      new ClicksPerYear(
          '\n  ช่างยนต์ \n\n จำนวน $mechanic_n คน \n\n ยังไม่เยี่ยมบ้าน',
          mechanic_n,
          Colors.grey),
      new ClicksPerYear(
          '\n  ช่างยนต์ \n\n จำนวน $mechanic_v คน \n\n  เยี่ยมบ้านเเล้ว',
          mechanic_v,
          Colors.blue),
    ];

    var dataelectrician = [
      new ClicksPerYear(
          '\n  ช่างไฟฟ้ากำลัง \n\n จำนวน $electrician_n คน \n\n ยังไม่เยี่ยมบ้าน',
          electrician_n,
          Colors.grey),
      new ClicksPerYear(
          '\n  ช่างไฟฟ้ากำลัง \n\n จำนวน $electrician_v คน \n\n  เยี่ยมบ้านเเล้ว',
          electrician_v,
          Colors.blue),
    ];

    var dataelectronic = [
      new ClicksPerYear(
          '\n  ช่างอิเล็กทรอนิกส์ \n\n จำนวน $electronic_n คน \n\n ยังไม่เยี่ยมบ้าน',
          electronic_n,
          Colors.grey),
      new ClicksPerYear(
          '\n  ช่างอิเล็กทรอนิกส์ \n\n จำนวน $electronic_v คน \n\n  เยี่ยมบ้านเเล้ว',
          electronic_v,
          Colors.blue),
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
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 40),
              child: Text(
                "ข้อมูลนักเรียน นักศึกษา ณ วันที่  $formatted",
                style: style,
              ),
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
    );
  }
}
