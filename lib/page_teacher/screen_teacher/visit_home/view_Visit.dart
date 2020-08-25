import 'dart:convert';
import 'dart:io';
import 'package:KABINBURI/page_teacher/screen_teacher/visit_home/view_pdf.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:http/http.dart' as http;
import 'package:KABINBURI/models/student_by_id_model.dart';
import 'package:KABINBURI/style/connect_api.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

// ignore: must_be_immutable
class ViewDataVisit extends StatefulWidget {
  int id;
  ViewDataVisit({Key key, this.id}) : super(key: key);

  @override
  _ViewDataVisitState createState() => _ViewDataVisitState();
}

class _ViewDataVisitState extends State<ViewDataVisit> {
  dynamic data;
  var name, phone, group, deparment, address, getstudent, documentpath;
  final pdf = pw.Document();
  String generatedPdfFilePath;

  writeOnPdf() {
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return <pw.Widget>[
            pw.Header(
              level: 5,
              child: pw.Center(),
            ),
            pw.Paragraph(
              text:
                  'Cursus aliquet netus aptent libero phasellus quam leo. Fames porttitor convallis rhoncus porttitor, natoque feugiat imperdiet. Turpis laoreet velit per adipiscing felis? Fringilla iaculis ridiculus laoreet consequat urna cubilia. Per rhoncus dapibus diam magna scelerisque orci iaculis dolor cum senectus rhoncus ipsum. Parturient pellentesque rhoncus ut. Ac quis erat ',
            ),
            pw.Paragraph(
              text:
                  'Cursus aliquet netus aptent libero phasellus quam leo. Fames porttitor convallis rhoncus porttitor, natoque feugiat imperdiet. Turpis laoreet velit per adipiscing felis? Fringilla iaculis ridiculus laoreet consequat urna cubilia. Per rhoncus dapibus diam magna scelerisque orci iaculis dolor cum senectus rhoncus ipsum. Parturient pellentesque rhoncus ut. Ac quis erat ',
            ),
            pw.Header(
              level: 1,
              child: pw.Text('Second Application'),
            ),
            pw.Paragraph(
              text:
                  'Cursus aliquet netus aptent libero phasellus quam leo. Fames porttitor convallis rhoncus porttitor, natoque feugiat imperdiet. Turpis laoreet velit per adipiscing felis? Fringilla iaculis ridiculus laoreet consequat urna cubilia. Per rhoncus dapibus diam magna scelerisque orci iaculis dolor cum senectus rhoncus ipsum. Parturient pellentesque rhoncus ut. Ac quis erat ',
            ),
            pw.Paragraph(
              text:
                  'Cursus aliquet netus aptent libero phasellus quam leo. Fames porttitor convallis rhoncus porttitor, natoque feugiat imperdiet. Turpis laoreet velit per adipiscing felis? Fringilla iaculis ridiculus laoreet consequat urna cubilia. Per rhoncus dapibus diam magna scelerisque orci iaculis dolor cum senectus rhoncus ipsum. Parturient pellentesque rhoncus ut. Ac quis erat ',
            ),
            pw.Paragraph(
              text:
                  'Cursus aliquet netus aptent libero phasellus quam leo. Fames porttitor convallis rhoncus porttitor, natoque feugiat imperdiet. Turpis laoreet velit per adipiscing felis? Fringilla iaculis ridiculus laoreet consequat urna cubilia. Per rhoncus dapibus diam magna scelerisque orci iaculis dolor cum senectus rhoncus ipsum. Parturient pellentesque rhoncus ut. Ac quis erat ',
            ),
          ];
        },
      ),
    );
  }

  Future savePDF() async {
    var directorydoc = await getApplicationDocumentsDirectory();
    documentpath = directorydoc.path;
    File file = File('$documentpath/visit.pdf');
    file.writeAsBytesSync(pdf.save());
  }

  @override
  void initState() {
    super.initState();
    print('ID Student: ' + '${widget.id}');
    apiGetStudentByID();
    generateExampleDocument();
  }

  Future<void> generateExampleDocument() async {
    var htmlContent = """
      <!DOCTYPE html>
      <html>
      <head>
          <style>
           h2 {
              text-align: center;
            }
          </style>
        </head>
        <body>
              <img src="/assets/images/logo.png" />
              <h2>วิทยาลัยการอาชีพกบินทร์บุรี แบบบันทึกการเยี่ยมบ้าน</h2>
              <div class="form-group">
                <table class="table table-striped">
                  <tr>
                    <th>ชื่อ</th>
                    <th>นาย</th>
                    <th>วรรณรัตน์</th>
                    <th>ชมชื่น</th>
                  </tr>
                </table>
              </div>
        </body>
      </html>
      """;

    Directory appDocDir = await getApplicationDocumentsDirectory();
    var targetPath = appDocDir.path;
    var targetFileName = "example-pdf";

    var generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
        htmlContent, targetPath, targetFileName);
    generatedPdfFilePath = generatedPdfFile.path;
  }

  Future apiGetStudentByID() async {
    var client = http.Client();
    var _obj = {"id": widget.id.toString()};
    var response = await client.post('$api/getStudentById', body: _obj);
    data = jsonDecode(response.body);
    if (data["status"] == true) {
      var result = data["result"];
      for (var map in result) {
        getstudent = DataStudentByID.fromJson(map);
        setState(() {
          phone = (getstudent.phonesSTD).length == 0
              ? "ไม่พบเบอร์ติดต่อ"
              : getstudent.phonesSTD;
          name = getstudent.prefixSTD +
              " " +
              getstudent.firstNameSTD +
              " " +
              getstudent.lastNameSTD;
          group = getstudent.studygroup;
          deparment = getstudent.deparment;
          //
          address = "บ้านเลขที่" +
              " " +
              getstudent.numberHomes +
              "  " +
              "หมู่ที่" +
              " " +
              getstudent.village +
              "  " +
              "ถนน" +
              " " +
              getstudent.road +
              "  " +
              "ตำบล" +
              " " +
              getstudent.district +
              "  " +
              "อำเภอ" +
              " " +
              getstudent.aumphuer +
              "  " +
              "จังหวัด" +
              " " +
              getstudent.province +
              "  " +
              "รหัสไปรษณีย์" +
              " " +
              getstudent.post;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: data != null
          ? ListView(
              children: <Widget>[
                Card(
                  elevation: 5.0,
                  child: Container(
                    padding: EdgeInsets.all(5.0),
                    child: Column(
                      children: <Widget>[
                        title(),
                        Divider(color: Colors.black87),
                        titleSub('ชื่อ / นามสกุล'),
                        Container(
                          margin: EdgeInsets.only(left: 20.0, top: 8.0),
                          width: MediaQuery.of(context).size.width,
                          child: showData(name),
                        ),
                        showDatas(context, 'เบอร์โทรศัพท์', phone),
                        titleSub('ระดับ / แผนก'),
                        showDatas(context, 'ระดับชั้น', group),
                        showDatas(context, 'แผนกวิชา', deparment),
                        titleSub('ที่อยู่'),
                        Container(
                          margin: EdgeInsets.only(
                              left: 20.0, top: 8.0, right: 20.0),
                          width: MediaQuery.of(context).size.width,
                          child: showData(address),
                        ),
                        titleSub('วัน / ที่ไปล่าสุด'),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: TextFormField(
                            decoration:
                                InputDecoration(border: OutlineInputBorder()),
                          ),
                        ),
                        titleSub('รูปภาพที่ไปเยี่ยม'),
                        Container(
                          padding: EdgeInsets.all(4.0),
                          child: Card(
                            elevation: 5.0,
                            child: Container(
                              width: 200.0,
                              height: 300.0,
                            ),
                          ),
                        ),
                        titleSub('รูปภาพแผนที่'),
                        Container(
                          padding: EdgeInsets.all(4.0),
                          child: Card(
                            elevation: 5.0,
                            child: Container(
                              width: 200.0,
                              height: 300.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : Center(
              child: Text(
                'ไม่พบข้อมูล',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
    );
  }

  Widget showDatas(BuildContext context, String text, var data) {
    return Container(
      margin: EdgeInsets.only(left: 20.0, top: 8.0),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: <Widget>[
          Text(text, style: TextStyle(fontSize: 18.0)),
          SizedBox(width: 15.0),
          Text(data, style: TextStyle(fontSize: 18.0)),
        ],
      ),
    );
  }

  Widget showData(var data) => Text(data, style: TextStyle(fontSize: 18.0));

  Widget titleSub(String text) {
    return Container(
      padding: EdgeInsets.only(top: 15.0, left: 10.0),
      child: Row(
        children: <Widget>[
          Text(text,
              style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget title() {
    return Container(
      padding: EdgeInsets.only(top: 15.0, left: 15.0),
      child: Row(
        children: <Widget>[
          Container(child: Icon(Icons.list)),
          Container(
              child: Text(
            'ข้อมูลนักศึกษา',
            style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.w600),
          )),
        ],
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('บันทึกการเยี่ยมบ้าน'),
      actions: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 10.0),
          child: IconButton(
            tooltip: 'ปริ้นรูปภาพ',
            icon: Icon(Icons.print),
            // onPressed: () async {
            // writeOnPdf();
            // await savePDF();
            // String filepart = '$documentpath/example.pdf';
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => PreeViewPDF(path: filepart),
            //   ),
            // );
            // },
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PDFViewerScaffold(
                  appBar: AppBar(
                    leading: IconButton(
                      color: Colors.black,
                      icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  path: generatedPdfFilePath,
                ),
              ),
            ),
          ),
        ),
      ],
      leading: IconButton(
        color: Colors.black,
        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}
