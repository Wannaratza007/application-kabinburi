import 'dart:convert';
import 'dart:io';
import 'package:KABINBURI/Teacher/signature.dart';
import 'package:KABINBURI/style/contsan.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:KABINBURI/model/student_model.dart';
import 'package:KABINBURI/style/connect_api.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';

// ignore: must_be_immutable
class VisitHome extends StatefulWidget {
  Student data;
  VisitHome({Key key, this.data}) : super(key: key);

  @override
  _VisitHomeState createState() => _VisitHomeState();
}

class _VisitHomeState extends State<VisitHome> {
  final _formKey = GlobalKey<FormState>();

  double lat, long;

  File _imagevisit;
  File _imageAddress;

  var visitBy;
  var nameStd, prefixstd;
  var behaviorD = TextEditingController();
  var behaviorNotD = TextEditingController();
  var problem = TextEditingController();
  var suggestion = TextEditingController();
  var nameGD = TextEditingController();
  var nameTHVisit = TextEditingController();
  var textrelevanceParents = TextEditingController();
  var textlivingStatus = TextEditingController();
  var textcharacteristicsAddress = TextEditingController();
  var textcomeToSchoolBy = TextEditingController();

  bool isrelevanceParents = false;
  bool islivingStatus = false;
  bool ischaracteristicsAddress = false;
  bool iscomeToSchoolBy = false;

  var relevanceParents;
  var livingStatus;
  var characteristicsAddress;
  var comeToSchoolBy;

  final _relevanceParents = ["บิดา", "มารดา", "อื่น ๆ"];
  final _livingStatus = [
    "บ้านส่วนตัว",
    "บ้านเช่า",
    "แฟลต",
    "วัด",
    "หอพัก",
    "บ้านญาติ",
    "บ้านตนเอง (ที่ดินเช่า)",
    "ห้องเช่า",
    "บ้านพักคนงาน",
    "อื่น ๆ"
  ];
  final _characteristicsAddress = [
    "อาคารพาณิชย์",
    "บ้านไม้ชั้นเดียว",
    "บ้านครึ่งตึกครึ่งไม้",
    "ตึกชั้นเดียว",
    "บ้านไม้สองชั้น",
    "อื่น ๆ"
  ];
  final _comeToSchoolBy = [
    "รถส่วนตัว",
    "รถโรงเรียน",
    "รถประจำทาง",
    "เดินเท้า",
    "อื่น ๆ"
  ];

  final picker = ImagePicker();

  bool isCheckdata = true;
  bool isloadData = false;
  bool saveing = true;

  @override
  void initState() {
    super.initState();
    setdata();
    // findlatlong();
  }

  // Get Location
  /*
  Future findlatlong() async {
    if (widget.data.latitude == null || widget.data.latitude == '') {
      print("get location");
      LocationData _locationData = await Location().getLocation();
      print("_locationData    $_locationData");
      print(_locationData);
      print(_locationData);
      setState(() {
        lat = _locationData.latitude;
        long = _locationData.longitude;
      });
    } else {
      print("Can not get location");
      setState(() {
        lat = double.parse(widget.data.latitude);
        long = double.parse(widget.data.longitude);
      });
    }
    print("Lat:  $lat" + " Long:  $long");
  }

  Set<Marker> markers() {
    return <Marker>[
      Marker(
        markerId: MarkerId("KabinburiApp"),
        position: LatLng(lat, long),
        infoWindow: InfoWindow(
          title: "ตำแหน่งของคุณ",
        ),
      )
    ].toSet();
  }
  */
  // End Get Location

  Future setdata() async {
    if (widget.data != null) {
      var pfs = await SharedPreferences.getInstance();
      visitBy = pfs.getString('prefix') +
          pfs.getString('firstname') +
          " " +
          pfs.getString('lastname');
      setState(() {
        isCheckdata = true;
        nameStd = widget.data.prefixStd +
            ' ' +
            widget.data.firstnameStd +
            '  ' +
            widget.data.lastnameStd +
            ' ' +
            'ระดับชั้น' +
            '  ' +
            widget.data.studygroup;
        nameGD.text = widget.data.prefixGd +
            widget.data.firstnameGd +
            ' ' +
            widget.data.lastnameGd;
        nameTHVisit.text = visitBy;

        isloadData = true;
      });
    } else {
      setState(() {
        isCheckdata = false;
      });
    }
  }

  Future apisaveDataVisit() async {
    // SweetAlert.show(context,
    //       subtitle: "Save...", style: SweetAlertStyle.loading);
    var relevanceParentsID;
    var livingStatusID;
    var characteristicsAddressID;
    var comeToSchoolByID;

    try {
      switch (relevanceParents) {
        case "บิดา":
          setState(() {
            relevanceParentsID = 1;
          });
          break;
        case "มารดา":
          setState(() {
            relevanceParentsID = 2;
          });
          break;
        case "อื่น ๆ":
          setState(() {
            relevanceParentsID = 3;
          });
          break;
      }

      switch (livingStatus) {
        case "บ้านส่วนตัว":
          setState(() {
            livingStatusID = 1;
          });
          break;
        case "บ้านเช่า":
          setState(() {
            livingStatusID = 2;
          });
          break;
        case "แฟลต":
          setState(() {
            livingStatusID = 3;
          });
          break;
        case "วัด":
          setState(() {
            livingStatusID = 4;
          });
          break;
        case "หอพัก":
          setState(() {
            livingStatusID = 5;
          });
          break;
        case "บ้านญาติ":
          setState(() {
            livingStatusID = 6;
          });
          break;
        case "บ้านตนเอง (ที่ดินเช่า)":
          setState(() {
            livingStatusID = 7;
          });
          break;
        case "ห้องเช่า":
          setState(() {
            livingStatusID = 8;
          });
          break;
        case "บ้านพักคนงาน":
          setState(() {
            livingStatusID = 9;
          });
          break;
        case "อื่น ๆ":
          setState(() {
            livingStatusID = 10;
          });
          break;
      }

      switch (characteristicsAddress) {
        case "อาคารพาณิชย์":
          setState(() {
            characteristicsAddressID = 1;
          });
          break;
        case "บ้านไม้ชั้นเดียว":
          setState(() {
            characteristicsAddressID = 2;
          });
          break;
        case "บ้านครึ่งตึกครึ่งไม้":
          setState(() {
            characteristicsAddressID = 3;
          });
          break;
        case "ตึกชั้นเดียว":
          setState(() {
            characteristicsAddressID = 4;
          });
          break;
        case "บ้านไม้สองชั้น":
          setState(() {
            characteristicsAddressID = 5;
          });
          break;
        case "อื่น ๆ":
          setState(() {
            characteristicsAddressID = 6;
          });
          break;
      }

      switch (comeToSchoolBy) {
        case "รถส่วนตัว":
          setState(() {
            comeToSchoolByID = 1;
          });
          break;
        case "รถโรงเรียน":
          setState(() {
            comeToSchoolByID = 2;
          });
          break;
        case "รถประจำทาง":
          setState(() {
            comeToSchoolByID = 3;
          });
          break;
        case "เดินเท้า":
          setState(() {
            comeToSchoolByID = 4;
          });
          break;
        case "อื่น ๆ":
          setState(() {
            comeToSchoolByID = 5;
          });
          break;
      }

      if (_imagevisit != null || _imageAddress != null) {
        String base64Imagevisit = base64Encode(_imagevisit.readAsBytesSync());
        String fileNamevisit = _imagevisit.path.split("/").last;
        String base64ImageAddress =
            base64Encode(_imageAddress.readAsBytesSync());
        String fileNameAddress = _imageAddress.path.split("/").last;

        var obj = {
          "studenID": (widget.data.student).toString(),
          "base64Imagevisit": base64Imagevisit,
          "fileNamevisit": fileNamevisit,
          "base64ImageAddress": base64ImageAddress,
          "fileNameAddress": fileNameAddress,
          "relevanceParentsID": (relevanceParentsID).toString(),
          "anotherRelevanceParents": textrelevanceParents.text.trim(),
          "livingStatusID": (livingStatusID).toString(),
          "anotherLivingStatus": textlivingStatus.text.trim(),
          "characteristicsAddressID": (characteristicsAddressID).toString(),
          "anotherCharacteristicsAddress":
              textcharacteristicsAddress.text.trim(),
          "comeToSchoolByID": (comeToSchoolByID).toString(),
          "anotherComeToSchoolBy": textcomeToSchoolBy.text.trim(),
          "behaviorD": behaviorD.text.trim(),
          "behaviorNotD": behaviorNotD.text.trim(),
          "problem": problem.text.trim(),
          "suggestion": suggestion.text.trim(),
          "nameGD": nameGD.text.trim(),
          "visit_By": visitBy,
          "latitude": lat,
          "longitude": long,
        };

        var _obj = jsonEncode(obj);
        final response = await http.post(
          '$api/server/student/visthome-student',
          headers: {
            'content-type': 'application/json',
          },
          body: _obj,
        );
        var data = jsonDecode(response.body);
        if (data["status"] == true) {
          setState(() {
            saveing = true;
          });
          EdgeAlert.show(context,
              title: 'บันทึกข้อมูลสำเร็จ',
              gravity: EdgeAlert.TOP,
              backgroundColor: Colors.green,
              icon: Icons.check_circle_outline);
          Navigator.pop(context, true);
        } else {
          SweetAlert.show(context,
              subtitle: data["result"], style: SweetAlertStyle.error);
          setState(() {
            saveing = true;
          });
        }
      } else {
        setState(() {
          saveing = true;
        });
        EdgeAlert.show(context,
            description: 'กรุณาเลือกรูปภาพ',
            gravity: EdgeAlert.TOP,
            backgroundColor: Colors.red);
      }
    } catch (e) {
      EdgeAlert.show(context,
          title: 'กรุณาลองใหม่',
          description: '$e',
          gravity: EdgeAlert.TOP,
          backgroundColor: Colors.red);
      setState(() {
        saveing = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.border_color),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Signture(
                        nameGD: widget.data.prefixGd +
                            widget.data.firstnameGd +
                            "  " +
                            widget.data.lastnameGd,
                        stdID: widget.data.student)),
              );
            },
          )
        ],
      ),
      body: isloadData == false
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [progress()],
              ),
            )
          : viewdata(),
    );
  }

  Widget viewdata() {
    return isCheckdata == false
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('ไม่พบข้อมูล', style: hintStyle)],
            ),
          )
        : Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.all(5.0),
              child: Card(
                elevation: 5.0,
                child: ListView(children: <Widget>[
                  SizedBox(height: 15.0),
                  titleSub('ข้อมูลนักศึกษา'),
                  SizedBox(height: 15.0),
                  showDatas(nameStd),
                  showDatas('แผนกวิชา   ${widget.data.deparmentName}'),
                  border(),
                  // widget.data.longitude == null || widget.data.longitude == ''
                  //     ? Container()
                  //     : showMap(),
                  // widget.data.longitude == null || widget.data.longitude == ''
                  //     ? Container()
                  //     : border(),
                  titleSub('รูปภาพการเยี่ยมบ้าน'),
                  SizedBox(height: 15.0),
                  buildpickimagevisit(context),
                  SizedBox(height: 15.0),
                  titleSub('รูปภาพที่อยู่'),
                  SizedBox(height: 15.0),
                  buildpickimageAddress(context),
                  SizedBox(height: 15.0),
                  titleSub('ผู้ปกครองเกี่ยวข้องกับนักเรียนเป็น'),
                  SizedBox(height: 15.0),
                  selectedValueRelevanceParents(),
                  isrelevanceParents == true
                      ? showcomment(
                          textrelevanceParents, 'อื่น ๆ  ระบุ...', true)
                      : SizedBox(height: 15.0),
                  titleSub('สถานะที่อยู่อาศัย'),
                  SizedBox(height: 15.0),
                  selectedValueLivingStatus(),
                  islivingStatus == true
                      ? showcomment(textlivingStatus, 'อื่น ๆ  ระบุ...', true)
                      : SizedBox(height: 15.0),
                  titleSub('ลักษณะของที่อยู่'),
                  SizedBox(height: 15.0),
                  selectedValueCharacteristicsAddress(),
                  ischaracteristicsAddress == true
                      ? showcomment(
                          textcharacteristicsAddress, 'อื่น ๆ  ระบุ...', true)
                      : SizedBox(height: 15.0),
                  titleSub('นักเรียนเดินทางมาโรงเรียน โดย'),
                  SizedBox(height: 15.0),
                  selectedValueComeToSchoolBy(),
                  iscomeToSchoolBy == true
                      ? showcomment(textcomeToSchoolBy, 'อื่น ๆ  ระบุ...', true)
                      : SizedBox(height: 15.0),
                  titleSub('พฤติกรรมของนักศึกษา'),
                  showcomment(behaviorD, 'พฤติกรรม ด้านดี', true),
                  showcomment(behaviorNotD, 'พฤติกรรม ที่ต้องปรับหรุง', true),
                  SizedBox(height: 15.0),
                  titleSub('ปัญหาของนักศึกษา'),
                  showcomment(problem, 'พฤติกรรม ด้านดี', true),
                  SizedBox(height: 15.0),
                  titleSub('ข้อเสนอแนะ'),
                  showcomment(suggestion, 'อื่นๆ...', true),
                  SizedBox(height: 15.0),
                  titleSub('ลงชื่อผู้ปกครอง'),
                  showcomment(nameGD, 'ชื่อผู้ปกครอง', true),
                  SizedBox(height: 15.0),
                  titleSub('ลงชื่อครูผู้ไปเยี่ยม'),
                  showcomment(nameTHVisit, 'ลงชื่อครูผู้ไปเยี่ยม', false),
                  buttonSVAE(),
                  SizedBox(height: 15.0),
                ]),
              ),
            ),
          );
  }

  // Show GoogleMap
  /*
  Widget showMap() {
    LatLng latLng = LatLng(lat, long);
    CameraPosition camera = CameraPosition(target: latLng, zoom: 16.0);
    return Container(
      height: 300.0,
      margin: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border.all(color: mainColor, width: 3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: GoogleMap(
        initialCameraPosition: camera,
        mapType: MapType.normal,
        onMapCreated: (controller) {},
        markers: markers(),
      ),
    );
  }
  */
  // End Show GoogleMap

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
            fontFamily: 'Mali',
          ),
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        textColor: Colors.white,
        color: Colors.blue,
        onPressed: () {
          hidekeyboard();
          if (_formKey.currentState.validate()) {
            if (saveing) {
              SweetAlert.show(context,
                  subtitle: "คุณต้องการบันทึกข้อมูลหรือไม่ ?",
                  style: SweetAlertStyle.confirm,
                  // ignore: missing_return
                  showCancelButton: true, onPress: (bool isConfirm) {
                if (isConfirm) {
                  SweetAlert.show(context,
                      subtitle: "Saveing....", style: SweetAlertStyle.loading);
                  setState(() {
                    saveing = false;
                  });
                  apisaveDataVisit();
                } else {
                  SweetAlert.show(context,
                      subtitle: "Canceled!", style: SweetAlertStyle.error);
                  setState(() {
                    saveing = false;
                  });
                }
              });
            } else {
              EdgeAlert.show(context,
                  title: 'กำลังบันทึกข้อมูล',
                  description: 'กรุณารอสักครู่ค่ะ...',
                  gravity: EdgeAlert.TOP,
                  backgroundColor: Colors.blue,
                  icon: Icons.check_circle_outline);
            }
          }
        },
      ),
    );
  }

  Widget showcomment(
      TextEditingController controller, String text, bool enabled) {
    return Container(
      margin: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      child: TextFormField(
        enabled: enabled,
        controller: controller,
        style: TextStyle(fontSize: 16.0, fontFamily: 'Mali'),
        decoration: InputDecoration(
          hintText: text,
          hintStyle: hintStyle,
          labelStyle: hintStyle,
          labelText: text,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ),
    );
  }

  Widget buildpickimageAddress(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: new Icon(Icons.image),
                  title: new Text('Gallery'),
                  onTap: () {
                    Navigator.of(context).pop();
                    getImageAddresst();
                  },
                ),
              ],
            ),
          ),
        );
      },
      child: Container(
        height: 300.0,
        decoration: BoxDecoration(
          border: Border.all(color: mainColor, width: 3),
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.all(12.0),
        child: Center(
          child: _imageAddress == null
              ? Icon(Icons.image, size: 80, color: Colors.grey)
              : Image.file(_imageAddress),
        ),
      ),
    );
  }

  Widget buildpickimagevisit(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: new Icon(Icons.camera_alt),
                  title: new Text('Camera'),
                  onTap: () {
                    getImageVisit('camera');
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: new Icon(Icons.image),
                  title: new Text('Gallery'),
                  onTap: () {
                    Navigator.of(context).pop();
                    getImageVisit('gallery');
                  },
                ),
              ],
            ),
          ),
        );
      },
      child: Container(
        height: 300.0,
        decoration: BoxDecoration(
          border: Border.all(color: mainColor, width: 3),
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.all(12.0),
        child: Center(
          child: _imagevisit == null
              ? Icon(Icons.image, size: 80, color: Colors.grey)
              : Image.file(_imagevisit),
        ),
      ),
    );
  }

  Future getImageAddresst() async {
    // var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    dynamic image = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _imageAddress = File(image.path);
    });
  }

  Future getImageVisit(String type) async {
    dynamic image;
    if (type == 'camera') {
      image = await picker.getImage(source: ImageSource.camera);
    } else if (type == 'gallery') {
      image = await picker.getImage(source: ImageSource.gallery);
    }
    if (image != null) {
      // GallerySaver.saveImage(_imagevisit.path, albumName: 'KabinBuriApp');
      setState(() {
        _imagevisit = File(image.path);
      });
    }
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
              fontWeight: FontWeight.w800,
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
      child: Text(
        data,
        style: TextStyle(
          fontSize: 18.0,
          fontFamily: 'Mali',
        ),
      ),
    );
  }

  Widget selectedValueRelevanceParents() {
    return Container(
      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(color: indexColor, width: 2),
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                icon: Icon(Icons.arrow_drop_down, color: indexColor),
                hint: Text("ผู้ปกครองเกี่ยวข้องกับนักเรียนเป็น",
                    style: hintStyle),
                value: relevanceParents,
                isDense: true,
                onChanged: (newValue) {
                  setState(() {
                    relevanceParents = newValue;
                    if (relevanceParents == "อื่น ๆ") {
                      setState(() {
                        isrelevanceParents = true;
                      });
                    } else {
                      setState(() {
                        isrelevanceParents = false;
                      });
                    }
                  });
                },
                items: _relevanceParents.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: hintStyle),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget selectedValueLivingStatus() {
    return Container(
      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(color: indexColor, width: 2),
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                icon: Icon(Icons.arrow_drop_down, color: indexColor),
                hint: Text("สถานะที่อยู่อาศัย", style: hintStyle),
                value: livingStatus,
                isDense: true,
                onChanged: (newValue) {
                  setState(() {
                    livingStatus = newValue;
                    if (livingStatus == "อื่น ๆ") {
                      setState(() {
                        islivingStatus = true;
                      });
                    } else {
                      setState(() {
                        islivingStatus = false;
                      });
                    }
                  });
                },
                items: _livingStatus.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: hintStyle),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget selectedValueCharacteristicsAddress() {
    return Container(
      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(color: indexColor, width: 2),
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                icon: Icon(Icons.arrow_drop_down, color: indexColor),
                hint: Text("ลักษณะของที่อยู่", style: hintStyle),
                value: characteristicsAddress,
                isDense: true,
                onChanged: (newValue) {
                  setState(() {
                    characteristicsAddress = newValue;
                    if (characteristicsAddress == "อื่น ๆ") {
                      setState(() {
                        ischaracteristicsAddress = true;
                      });
                    } else {
                      setState(() {
                        ischaracteristicsAddress = false;
                      });
                    }
                  });
                },
                items: _characteristicsAddress.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: hintStyle),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget selectedValueComeToSchoolBy() {
    return Container(
      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(color: indexColor, width: 2),
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                icon: Icon(Icons.arrow_drop_down, color: indexColor),
                hint: Text("นักเรียนเดินทางมาโรงเรียน โดย", style: hintStyle),
                value: comeToSchoolBy,
                isDense: true,
                onChanged: (newValue) {
                  setState(() {
                    comeToSchoolBy = newValue;
                    if (comeToSchoolBy == "อื่น ๆ") {
                      setState(() {
                        iscomeToSchoolBy = true;
                      });
                    } else {
                      setState(() {
                        iscomeToSchoolBy = false;
                      });
                    }
                  });
                },
                items: _comeToSchoolBy.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: hintStyle),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }

}
