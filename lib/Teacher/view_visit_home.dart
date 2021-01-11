import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:KABINBURI/model/student_model.dart';
import 'package:KABINBURI/style/connect_api.dart';
import 'package:KABINBURI/style/contsan.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:sweetalert/sweetalert.dart';

// ignore: must_be_immutable
class ViewVistHome extends StatefulWidget {
  Student data;
  ViewVistHome({Key key, this.data}) : super(key: key);

  @override
  _ViewVistHomeState createState() => _ViewVistHomeState();
}

class _ViewVistHomeState extends State<ViewVistHome> {
  var nameStd, prefixstd, firstSTD, lastSTD;

  var behaviorD = TextEditingController();
  var behaviorNotD = TextEditingController();
  var problem = TextEditingController();
  var suggestion = TextEditingController();
  var nameGD = TextEditingController();
  var nameTHVisit = TextEditingController();
  var textrelevanceParent = TextEditingController();
  var textlivingStatus = TextEditingController();
  var textcharacteristicsAddress = TextEditingController();
  var textcomeToSchoolBy = TextEditingController();
  var otherrelevanceParent = TextEditingController();
  var otherlivingStatus = TextEditingController();
  var othercharacteristicsAddress = TextEditingController();
  var othercomeToSchoolBy = TextEditingController();

  bool isCheckdata = true;
  bool isloadData = false;
  List<String> filePaths = [];

  @override
  void initState() {
    super.initState();
    setdata();
  }

  Future sharefile() async {
    var response = await http.get(
        'https://shop.esys.eu/media/image/6f/8f/af/amlog_transport-berwachung.jpg');
    var res = jsonDecode(response.body);
    print(res);
    print(res);
    // var request = await HttpClient().getUrl(Uri.parse(
    //     'https://shop.esys.eu/media/image/6f/8f/af/amlog_transport-berwachung.jpg'));
    // var response = await request.close();
    // Uint8List bytes = await consolidateHttpClientResponseBytes(response);
    // await Share.file('ESYS AMLOG', 'amlog.jpg', bytes, 'image/jpg');
  }

  Future setdata() async {
    if (widget.data != null) {
      setState(() {
        isloadData = true;
        nameStd = widget.data.prefixStd +
            ' ' +
            widget.data.firstnameStd +
            '  ' +
            widget.data.firstnameStd +
            ' ' +
            'ระดับชั้น' +
            '  ' +
            widget.data.studygroup;
        behaviorD.text = widget.data.behaviorD;
        behaviorNotD.text = widget.data.behaviorNotD;
        problem.text = widget.data.problem;
        nameGD.text = widget.data.nameParents;
        nameTHVisit.text = widget.data.visitBy;
        suggestion.text = widget.data.suggestion;
        textrelevanceParent.text = widget.data.relevanceParents;
        textlivingStatus.text = widget.data.livingStatus;
        textcharacteristicsAddress.text = widget.data.characteristicsAddress;
        textcomeToSchoolBy.text = widget.data.comeToSchoolBy;
        otherrelevanceParent.text = widget.data.anotherRelevanceParents;
        otherlivingStatus.text = widget.data.anotherLivingStatus;
        othercharacteristicsAddress.text =
            widget.data.anotherCharacteristicsAddress;
        othercomeToSchoolBy.text = widget.data.anotherComeToSchoolBy;
        isCheckdata = true;
      });
    } else {
      setState(() {
        isCheckdata = false;
      });
    }
  }

  Future getPDF(String type) async {
    try {
      var _url = '$api/api/form/studentInformation';
      var obj = {
        "userID": (widget.data.student).toString(),
      };
      var _obj = jsonEncode(obj);
      var response = await http.post(_url,
          headers: {
            'content-type': 'application/json',
          },
          body: _obj);
      var res = jsonDecode(response.body);
      if (res != null) {
        if (type == 'print') {
          print('Print File');
          printFile(res).then((value) => {
                if (value)
                  {
                    SweetAlert.show(
                      context,
                      subtitle: "success",
                      style: SweetAlertStyle.success,
                      // ignore: missing_return
                      onPress: (isConfirm) {
                        Navigator.pop(context, true);
                      },
                    ),
                  }
              });
        } else if (type == 'share') {
          print('share File');
          sharefile();
          // saveAndShare(res);
        }
      }
    } catch (e) {
      Navigator.of(context).pop();
      EdgeAlert.show(context,
          title: 'กรุณาลองใหม่',
          description: '$e',
          gravity: EdgeAlert.TOP,
          backgroundColor: Colors.red);
    }
  }

  Future printFile(var filepdfname) async {
    try {
      http.Response response = await http.get('$api/form/pdf/$filepdfname');
      var pdfData = response.bodyBytes;
      await Printing.layoutPdf(
          onLayout: (PdfPageFormat format) async => pdfData);
      return true;
    } catch (e) {
      SweetAlert.show(
        context,
        subtitle: "$e",
        style: SweetAlertStyle.confirm,
        showCancelButton: false,
      );
      return false;
    }
  }

  Future saveAndShare(var filepdfname) async {
    try {
      // final filename = "บันทึกการเยี่ยมบ้าน" +
      //     widget.data.firstnameStd +
      //     "  " +
      //     widget.data.lastnameStd +
      //     ".pdf";
      // final RenderBox box = context.findRenderObject();
      // if (Platform.isAndroid) {
      //   final url = "$api/form/pdf/$filepdfname";
      //   var response = await get(url);
      //   final documentDirectory = (await getExternalStorageDirectory()).path;
      //   File file = new File('$documentDirectory/$filename');
      //   file.writeAsBytesSync(response.bodyBytes);

      //   setState(() {
      //     filePaths.add('$documentDirectory/$filename');
      //   });
      //   Share.shareFiles(filePaths,
      //       subject: '$filename',
      //       text: '',
      //       sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
      //   SweetAlert.show(
      //     context,
      //     subtitle: "success",
      //     style: SweetAlertStyle.success,
      //     // ignore: missing_return
      //     onPress: (isConfirm) {
      //       Navigator.pop(context, true);
      //     },
      //   );
      // }
      // setState(() {
      //   filePaths = [];
      // });
    } catch (e) {
      SweetAlert.show(context, subtitle: "$e", style: SweetAlertStyle.error);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: isloadData == false
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [progress()],
              ),
            )
          : viewData(context),
    );
  }

  Widget viewData(BuildContext context) {
    return isCheckdata == false
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('ไม่พบข้อมูล', style: hintStyle)],
            ),
          )
        : ListView(children: <Widget>[
            SizedBox(height: 15.0),
            titleSub('ข้อมูลนักศึกษา'),
            SizedBox(height: 15.0),
            showDatas(nameStd),
            showDatas('แผนกวิชา     ${widget.data.deparmentName}'),
            border(),
            titleSub('รูปภาพการเยี่ยมบ้าน'),
            SizedBox(height: 15.0),
            buildpickimagevisit(context),
            SizedBox(height: 15.0),
            titleSub('รูปภาพที่อยู่นักศึกษา'),
            SizedBox(height: 15.0),
            buildpickimageAddress(context),
            SizedBox(height: 15.0),
            titleSub('ผู้ปกครองเกี่ยวข้องกับนักเรียนเป็น'),
            inputcomment(
                textrelevanceParent, 'ผู้ปกครองเกี่ยวข้องกับนักเรียนเป็น'),
            widget.data.relevanceParents == "อื่น ๆ"
                ? inputcomment(otherrelevanceParent, '')
                : Container(),
            SizedBox(height: 15.0),
            titleSub('สถานะที่อยู่อาศัย'),
            inputcomment(textlivingStatus, 'สถานะที่อยู่อาศัย'),
            widget.data.livingStatus == "อื่น ๆ"
                ? inputcomment(otherlivingStatus, '')
                : Container(),
            SizedBox(height: 15.0),
            titleSub('ลักษณะของที่อยู่'),
            inputcomment(textcharacteristicsAddress, 'ลักษณะของที่อยู่'),
            widget.data.characteristicsAddress == "อื่น ๆ"
                ? inputcomment(othercharacteristicsAddress, '')
                : Container(),
            SizedBox(height: 15.0),
            titleSub('นักเรียนเดินทางมาโรงเรียน โดย'),
            inputcomment(textcomeToSchoolBy, 'นักเรียนเดินทางมาโรงเรียน โดย'),
            widget.data.comeToSchoolBy == "อื่น ๆ"
                ? inputcomment(othercomeToSchoolBy, '')
                : Container(),
            SizedBox(height: 15.0),
            titleSub('พฤติกรรมของนักศึกษา'),
            inputcomment(behaviorD, 'พฤติกรรม ด้านดี'),
            inputcomment(behaviorNotD, 'พฤติกรรม ที่ต้องปรับหรุง'),
            SizedBox(height: 15.0),
            titleSub('ปัญหาของนักศึกษา'),
            inputcomment(problem, 'พฤติกรรม ด้านดี'),
            SizedBox(height: 15.0),
            titleSub('ข้อเสนอแนะ'),
            inputcomment(suggestion, 'อื่นๆ...'),
            SizedBox(height: 15.0),
            titleSub('ชื่อผู้ปกครอง'),
            inputcomment(nameGD, 'ชื่อผู้ปกครอง'),
            SizedBox(height: 15.0),
            titleSub('ชื่อครูผู้ไปเยี่ยม'),
            inputcomment(nameTHVisit, 'ชื่อผู้ปกครอง'),
            buttonPrint(),
            buttonSVAEShare(),
            SizedBox(height: 15.0),
          ]);
  }

  Widget buttonPrint() {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(8.0),
      height: 65.0,
      child: RaisedButton(
        child: Text(
          'Print File',
          style: TextStyle(fontSize: 24.0, fontFamily: 'Mali'),
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        textColor: Colors.white,
        color: Colors.green,
        onPressed: () {
          getPDF('print');
          SweetAlert.show(context,
              subtitle: "loading...", style: SweetAlertStyle.loading);
        },
      ),
    );
  }

  Widget buttonSVAEShare() {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(8.0),
      height: 65.0,
      child: RaisedButton(
        child: Text(
          'Share File',
          style: TextStyle(fontSize: 24.0, fontFamily: 'Mali'),
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        textColor: Colors.white,
        color: Colors.blue,
        onPressed: () {
          sharefile();
          // getPDF('share');
          // SweetAlert.show(context,
          //     subtitle: "loading...", style: SweetAlertStyle.loading);
        },
      ),
    );
  }

  Widget inputcomment(TextEditingController controller, String label) {
    return Container(
      margin: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      child: TextFormField(
        enabled: false,
        controller: controller,
        style: hintStyle,
        decoration: InputDecoration(
          // hintText: hini,
          labelText: label,
          labelStyle: hintStyle,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  Widget buildpickimageAddress(BuildContext context) {
    return Container(
      height: 300.0,
      decoration: BoxDecoration(
        border: Border.all(color: mainColor, width: 3),
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.all(12.0),
      child: widget.data.imageMap == null || widget.data.imageMap == ''
          ? notedata()
          : CachedNetworkImage(
              imageUrl: '$api/image/address/${widget.data.imageMap}',
              fit: BoxFit.cover,
            ),
    );
  }

  Widget buildpickimagevisit(BuildContext context) {
    return Container(
      height: 300.0,
      decoration: BoxDecoration(
        border: Border.all(color: mainColor, width: 3),
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.all(12.0),
      child: widget.data.imageVisit == '' || widget.data.imageVisit == null
          ? notedata()
          : CachedNetworkImage(
              imageUrl: '$api/image/visit/${widget.data.imageVisit}',
              fit: BoxFit.cover,
            ),
    );
  }

  Widget border() {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Divider(color: Colors.black87),
    );
  }

  Widget titleSub(String text) {
    return Container(
      padding: EdgeInsets.only(left: 20.0),
      child: Row(
        children: <Widget>[
          Text(
            text,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Mali',
            ),
          ),
        ],
      ),
    );
  }

  Widget showDatas(var data) {
    return Container(
      margin: EdgeInsets.only(left: 20.0, top: 8.0),
      width: MediaQuery.of(context).size.width,
      child: Text(data, style: TextStyle(fontSize: 18.0, fontFamily: 'Mali')),
    );
  }
}
