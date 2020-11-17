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

class HomePage extends StatelessWidget {
  var style = TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold);
  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('dd-MM-yyyy');
  final String formatted = formatter.format(now);

  @override
  Widget build(BuildContext context) {
    dynamic device = MediaQuery.of(context);

    var datacom = [
      new ClicksPerYear('\n ยังไม่เยี่ยมบ้าน  \n\n  แผนกวิชาคอมพิวเตอร์ธุรกิจ',
          12, Colors.grey),
      new ClicksPerYear('\n เยี่ยมบ้านเเล้ว  \n\n  แผนกวิชาคอมพิวเตอร์ธุรกิจ',
          42, Colors.blue),
    ];

    var dataaccount = [
      new ClicksPerYear(
          '\n ยังไม่เยี่ยมบ้าน  \n\n   แผนกวิชาการบัญชี', 12, Colors.grey),
      new ClicksPerYear(
          '\n เยี่ยมบ้านเเล้ว  \n\n   แผนกวิชาการบัญชี', 42, Colors.blue),
    ];

    var datamaintenance = [
      new ClicksPerYear(
          '\n ยังไม่เยี่ยมบ้าน  \n\n   แผนกวิชาช่างซ่อมบำรุง', 12, Colors.grey),
      new ClicksPerYear(
          '\n เยี่ยมบ้านเเล้ว  \n\n   แผนกวิชาช่างซ่อมบำรุง', 42, Colors.blue),
    ];

    var dataretail = [
      new ClicksPerYear(
          '\n ยังไม่เยี่ยมบ้าน  \n\n   แผนกวิชาธุรกิจค้าปลีก', 12, Colors.grey),
      new ClicksPerYear(
          '\n เยี่ยมบ้านเเล้ว  \n\n   แผนกวิชาธุรกิจค้าปลีก', 42, Colors.blue),
    ];

    var datamechanic = [
      new ClicksPerYear(
          '\n ยังไม่เยี่ยมบ้าน  \n\n   แผนกวิชาช่างยนต์', 12, Colors.grey),
      new ClicksPerYear(
          '\n เยี่ยมบ้านเเล้ว  \n\n   แผนกวิชาช่างยนต์', 42, Colors.blue),
    ];

    var dataelectrician = [
      new ClicksPerYear('\n ยังไม่เยี่ยมบ้าน  \n\n   แผนกวิชาช่างไฟฟ้ากำลัง',
          12, Colors.grey),
      new ClicksPerYear(
          '\n เยี่ยมบ้านเเล้ว  \n\n   แผนกวิชาช่างไฟฟ้ากำลัง', 42, Colors.blue),
    ];

    var dataelectronic = [
      new ClicksPerYear(
          '\n ยังไม่เยี่ยมบ้าน  \n\n   แผนกวิชาช่างอิเล็กทรอนิกส์',
          12,
          Colors.grey),
      new ClicksPerYear('\n เยี่ยมบ้านเเล้ว  \n\n   แผนกวิชาช่างอิเล็กทรอนิกส์',
          42, Colors.blue),
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

    return new Scaffold(
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

    /* 
                Text('แผนกวิชา คอมพิวเตอร์ธุรกิจ', style: style),
                chartWidgetcom,
                Text('แผนกวิชา การบัญชี', style: style),
                chartWidgetaccount,
                Text('แผนกวิชา ช่างซ่อมบำรุง', style: style),
                chartWidgetmaintenance,
                Text('แผนกวิชา ธุรกิจค้าปลีก', style: style),
                chartWidgetretail,
                Text('แผนกวิชา ช่างยนต์', style: style),
                chartWidgetmechanic,
                Text('แผนกวิชา ช่างไฟฟ้ากำลัง', style: style),
                chartWidgetelectrician,
                Text('แผนกวิชา ช่างอิเล็กทรอนิกส์', style: style),
                chartWidgetelectronic,
    */
  }
}
