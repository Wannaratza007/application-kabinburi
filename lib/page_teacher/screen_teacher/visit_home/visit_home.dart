import 'dart:convert';
import 'dart:io';
import 'package:KABINBURI/models/student_by_id_model.dart';
import 'package:KABINBURI/page_teacher/screen_teacher/visit_home/signature/signature.dart';
import 'package:KABINBURI/style/connect_api.dart';
import 'package:KABINBURI/style/contsan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';

// ignore: must_be_immutable
class VisitHome extends StatefulWidget {
  int id;
  VisitHome({Key key, this.id}) : super(key: key);

  @override
  _VisitHomeState createState() => _VisitHomeState();
}

class _VisitHomeState extends State<VisitHome> {
  var behaviorD = TextEditingController();
  var behaviorNotD = TextEditingController();
  var problem = TextEditingController();
  var suggestion = TextEditingController();
  List<Asset> imagesAddress = List<Asset>();
  List<Asset> imagesMap = List<Asset>();
  List<String> imagelist = List<String>();
  dynamic getstudent, data;
  String imageB64Map;
  File _image;
  var name,
      phone,
      group,
      deparment,
      numberH,
      village,
      road,
      district,
      aumphuer,
      province,
      post,
      m,
      a,
      imageB64address;

  @override
  void initState() {
    super.initState();
    print('ID Student: ' + '${widget.id}');
    apiGetStudentByID();
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
          numberH =
              (getstudent.numberHomes) == null ? '-' : getstudent.numberHomes;
          village = (getstudent.village) == null ? '-' : getstudent.village;
          road = (getstudent.road) == null ? '-' : getstudent.road;
          district = (getstudent.district) == null ? '-' : getstudent.district;
          aumphuer = (getstudent.aumphuer) == null ? '-' : getstudent.aumphuer;
          province = (getstudent.province) == null ? '-' : getstudent.province;
          post = (getstudent.post) == null ? '-' : getstudent.post;
        });
      }
    }
  }

  Future apisaveDataVisit() async {
    var client = http.Client();
    SharedPreferences pfs = await SharedPreferences.getInstance();
    var visitBy = pfs.getString('firstname') + " " + pfs.getString('lastname');
    try {
      // SweetAlert.show(context,
      //     subtitle: "Save...", style: SweetAlertStyle.loading);
      for (a in imagesAddress) {
        ByteData byteData = await a.getByteData();
        List<int> imageData = byteData.buffer.asUint8List();
        imageB64address = base64Encode(imageData);
      }
      imagelist = [imageB64address];
      print('imagelist : $imagelist');
      // for (m in imagesMap) {
      //   ByteData byteData = await m.getByteData();
      //   List<int> imageData = byteData.buffer.asUint8List();
      //   imageB64Map = base64Encode(imageData);
      // }
      /* if (_image == null) return;
      String base64ImageMap = base64Encode(_image.readAsBytesSync());
      String fileNameimageMap = _image.path.split("/").last; */
      var _obj = {
        // "statusId": widget.id.toString(),
        // "name_image_address": a.name.toString(),
        // "image_address": imagelist.toString(),
        // "name_image_map": m.name.toString(),
        // "image_map": imageB64Map.toString(),
        // "behaviorD": behaviorD.text.trim(),
        // "behaviorNotD": behaviorNotD.text.trim(),
        // "problem": problem.text.trim(),
        // "suggestion": suggestion.text.trim(),
        // "visit_By": visitBy,
        "send_data": true,
      };
      var obj = jsonEncode(_obj);
      print(_obj);
      var response = await client.post('$api/visitHome', body: obj);
      var data = jsonDecode(response.body);
      if (data["status"] == true) {
        new Future.delayed(new Duration(microseconds: 1500), () {
          SweetAlert.show(
            context,
            subtitle: "Success!",
            style: SweetAlertStyle.success,
          );
        });
      }
      return true;
    } finally {
      client.close();
    }
  }

  // Future getImagegallery() async {
  //   var image = await ImagePicker.pickImage(source: ImageSource.gallery);
  //   setState(() {
  //     _image = image;
  //   });
  // }

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
                        pickimageVisit(),
                        showImages(context, imagesAddress),
                        pickimageMap(),
                        showImages(context, imagesMap),
                        // showImagesMap(),
                        titleSub('พฤติกรรมของนักศึกษา'),
                        inputcomment(
                            behaviorD, 'พฤติกรรม ด้านดี', 'พฤติกรรม ด้านดี'),
                        inputcomment(behaviorNotD, 'พฤติกรรม ที่ต้องปรับหรุง',
                            'พฤติกรรม ที่ต้องปรับหรุง'),
                        titleSub('ปัญหาของนักศึกษา'),
                        inputcomment(
                            problem, 'พฤติกรรม ด้านดี', 'พฤติกรรม ด้านดี'),
                        titleSub('ข้อเสนอแนะ'),
                        inputcomment(suggestion, 'อื่นๆ...', 'อื่นๆ...'),
                        buttonSVAE(),
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

  Widget showImagesMap() {
    return Container(
      padding: EdgeInsets.fromLTRB(15.0, 4.0, 15.0, 4.0),
      child: Card(
        elevation: 5.0,
        child: Container(
          width: 300.0,
          height: 300.0,
          child: Center(
            child: _image == null
                ? Container(
                    child: Center(
                      child: Text("Not Image"),
                    ),
                  )
                : Container(
                    padding: EdgeInsets.all(5.0),
                    child: Image.file(_image),
                  ),
          ),
        ),
      ),
    );
  }

  Widget showImages(BuildContext context, var pathimages) {
    return Container(
      padding: EdgeInsets.fromLTRB(15.0, 4.0, 15.0, 4.0),
      child: Card(
        elevation: 5.0,
        child: Container(
          width: 300.0,
          height: 300.0,
          child: Center(
            child: pathimages.length == 0
                ? Text("Not Image")
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: (pathimages).length,
                    itemBuilder: (context, index) => Container(
                      margin: EdgeInsets.all(10.0),
                      child: AssetThumb(
                        asset: pathimages[index],
                        width: 300,
                        height: 300,
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget buttonSVAE() {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(8.0),
      height: 65.0,
      child: RaisedButton(
        child: Text(
          'SVAE',
          style: TextStyle(
            fontSize: 24.0,
          ),
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        textColor: Colors.white,
        color: Colors.blue,
        onPressed: () {
          SweetAlert.show(context,
              subtitle: "คุณต้องการบันทึกข้อมูลหรือไม่ ?",
              style: SweetAlertStyle.confirm,
              showCancelButton: true, onPress: (bool isConfirm) {
            if (isConfirm) {
              apisaveDataVisit();
              // apisaveDataVisit().then((res) => {
              //       if (res == true)
              //         {Navigator.of(context).pop()}
              //     });
            } else {
              SweetAlert.show(context,
                  subtitle: "Canceled!", style: SweetAlertStyle.error);
            }
            return false;
          });
        },
      ),
    );
  }

  Widget inputcomment(
      TextEditingController controller, String hini, String label) {
    return Container(
      margin: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      child: TextFormField(
        controller: controller,
        style: TextStyle(fontSize: 16.0),
        decoration: InputDecoration(
          hintText: hini,
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  Future loadAssetsMap() async {
    List<Asset> resultList = List<Asset>();
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 1,
        enableCamera: true,
        selectedAssets: imagesMap,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
      );
    } on Exception catch (e) {
      print(e.toString());
    }
    if (!mounted) return;
    setState(() {
      imagesMap = resultList;
    });
  }

  Future loadAssetsAddress() async {
    List<Asset> resultList = List<Asset>();
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 4,
        enableCamera: true,
        selectedAssets: imagesAddress,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
      );
    } on Exception catch (e) {
      print(e.toString());
    }
    if (!mounted) return;
    setState(() {
      imagesAddress = resultList;
    });
  }

  Widget pickimageMap() {
    return Row(
      children: <Widget>[
        titleSub('เพิ่มรูปภาพเยี่ยมบ้าน'),
        SizedBox(width: 10.0),
        Container(
          margin: EdgeInsets.only(top: 15.0),
          child: RaisedButton(
            onPressed: () => loadAssetsMap(),
            color: primaryColor,
            child: Text(
              'Pick Images',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
    // return Row(
    //   children: <Widget>[
    //     titleSub('เพิ่มแผนที่'),
    //     SizedBox(width: 10.0),
    //     Container(
    //       margin: EdgeInsets.only(top: 15.0),
    //       child: RaisedButton(
    //         onPressed: () => getImagegallery(),
    //         color: primaryColor,
    //         child: Text(
    //           'Pick Images',
    //           style: TextStyle(color: Colors.white),
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }

  Widget pickimageVisit() {
    return Row(
      children: <Widget>[
        titleSub('เพิ่มรูปภาพเยี่ยมบ้าน'),
        SizedBox(width: 10.0),
        Container(
          margin: EdgeInsets.only(top: 15.0),
          child: RaisedButton(
            onPressed: () => loadAssetsAddress(),
            color: primaryColor,
            child: Text(
              'Pick Images',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
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
      title: Text('เยี่ยมบ้านนักศึกษา'),
      leading: IconButton(
        color: Colors.black,
        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 10.0),
          child: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SignturePage(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
