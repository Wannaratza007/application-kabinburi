import 'dart:convert';
import 'package:KABINBURI/Teacher/main_Teacher.dart';
import 'package:KABINBURI/style/singout.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:http/http.dart' as http;
import 'package:KABINBURI/style/connect_api.dart';
import 'package:KABINBURI/style/contsan.dart';
import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';

class AddNewStudent extends StatefulWidget {
  AddNewStudent({Key key}) : super(key: key);

  @override
  _AddNewStudentState createState() => _AddNewStudentState();
}

class _AddNewStudentState extends State<AddNewStudent> {
  final _formKey = GlobalKey<FormState>();
  var firstnameuser, lastnameuser, deparmentID, deparmentName;

  var idSTD = TextEditingController();
  var firstnameSTD = TextEditingController();
  var lastnameSTD = TextEditingController();
  var phoneSTD = TextEditingController();
  var cardNumberSTD = TextEditingController();
  var firstnameGD = TextEditingController();
  var lastnameGD = TextEditingController();
  var phoneGD = TextEditingController();
  var numbersHome = TextEditingController();
  var villages = TextEditingController();
  var road = TextEditingController();
  var alley = TextEditingController();
  var postcodes = TextEditingController();
  var userdeparment = TextEditingController();

  List<DropdownMenuItem> itemsListprovince = [];
  List<DropdownMenuItem> itemsListamphures = [];
  List<DropdownMenuItem> itemsListdistricts = [];

  dynamic province;
  dynamic amphures;
  dynamic districts;
  dynamic listprovince;
  dynamic listamphures;
  dynamic listdistricts;

  String selectedValueprovince;
  String selectedValueamphures;
  String selectedValuedistricts;

  bool issaved = true;

  var currentSelectedprefixSTD;
  var currentSelectedprefixGD;
  var currentSelectedgrade1;
  var currentSelectedgrade2;
  var currentSelectedgrade3;

  final _grade1 = ["ปวช.", "ปวส."];
  final _grade2 = ["1", "2", "3"];
  final _grade3 = ["1", "2", "3", "4", "5", "6"];
  final _prefix = ["นาย", "นาง", "นางสาว"];

  @override
  void initState() {
    super.initState();
    finduser();
    apiqgetprovince();
  }

  Future finduser() async {
    var pfs = await SharedPreferences.getInstance();
    setState(() {
      firstnameuser = pfs.getString('firstname');
      lastnameuser = pfs.getString('lastname');
      deparmentID = pfs.getInt('deparmentID');
      deparmentName = pfs.getString('deparment');
      userdeparment.text = 'แผนกวิชา  ' + deparmentName;
    });
  }

  Future apiAddstudent() async {
    SweetAlert.show(context,
        subtitle: "Saveing...", style: SweetAlertStyle.loading);
    var grades = currentSelectedgrade1 +
        currentSelectedgrade2 +
        '/' +
        currentSelectedgrade3;
    var obj = {
      "deparmentID": (deparmentID).toString(),
      "codeSTD": idSTD.text.trim(),
      "prefixSTD": currentSelectedprefixSTD,
      "firstNameSTD": firstnameSTD.text.trim(),
      "lastNameSTD": lastnameSTD.text.trim(),
      "phonesSTD": phoneSTD.text.trim(),
      "cardNumber": cardNumberSTD.text.trim(),
      "studygroup": grades,
      "prefixGD": currentSelectedprefixGD,
      "firstNameGD": firstnameGD.text.trim(),
      "lastNameGD": lastnameGD.text.trim(),
      "phonesGD": phoneGD.text.trim(),
      "numberHomes": numbersHome.text.trim(),
      "village": villages.text.trim(),
      "road": road.text.trim(),
      "alley": alley.text.trim(),
      "post": (districts["post"]).toString(),
      "province": province["province"],
      "amphures": amphures["amphures"],
      "districts": districts["districts"],
    };
    var _obj = jsonEncode(obj);
    try {
      var res = await http.post(
        '$api/server/student/add-student',
        headers: {
          'content-type': 'application/json',
        },
        body: _obj,
      );
      var data = json.decode(res.body);
      if (data["status"] == true) {
        EdgeAlert.show(context,
            title: 'บันทึกข้อมูลสำเร็จ',
            gravity: EdgeAlert.TOP,
            backgroundColor: Colors.green,
            icon: Icons.check_circle_outline);
        setState(() {
          issaved = true;
        });
        pushRemove(context, MainTeacherPage());
      } else {
        EdgeAlert.show(context,
            title: 'เกิดข้อผิดพลาด',
            description: 'กรุณาลองใหม่อีกครั้งค่ะ...',
            gravity: EdgeAlert.TOP,
            backgroundColor: Colors.red,
            icon: Icons.check_circle_outline);
      }
    } catch (e) {
      EdgeAlert.show(context,
          title: 'กรุณาลองใหม่',
          description: '$e',
          gravity: EdgeAlert.TOP,
          backgroundColor: Colors.red);
    }
  }

  Future apiqgetprovince() async {
    try {
      var response = await http.post(
        '$api/server/student/province',
        headers: {
          'content-type': 'application/json',
        },
      );
      var res = jsonDecode(response.body);
      var status = res["status"];
      if (status) {
        setState(() {
          listprovince = res["result"] as List;
          listprovince.forEach((item) {
            itemsListprovince.add(DropdownMenuItem(
              child: Text(item["name_th"], style: hintStyle),
              value: {
                'id': item["id"],
                'province': item["name_th"],
              },
            ));
          });
        });
      }
    } catch (e) {
      EdgeAlert.show(context,
          title: 'กรุณาลองใหม่',
          description: '$e',
          gravity: EdgeAlert.TOP,
          backgroundColor: Colors.red);
    }
  }

  Future apiqgetamphures() async {
    if (province["id"] != null) {
      try {
        var obj = {"idprovince": (province["id"]).toString()};
        var _obj = jsonEncode(obj);
        var response = await http.post('$api/server/student/amphures',
            headers: {
              'content-type': 'application/json',
            },
            body: _obj);
        var res = jsonDecode(response.body);
        var status = res["status"];
        if (status) {
          setState(() {
            listamphures = res['result'] as List;
            listamphures.forEach((item) {
              itemsListamphures.add(DropdownMenuItem(
                child: Text(item["name_th"], style: hintStyle),
                value: {
                  'id': item["id"],
                  'amphures': item["name_th"],
                },
              ));
            });
          });
        }
      } catch (e) {
        EdgeAlert.show(context,
            title: 'กรุณาลองใหม่',
            description: '$e',
            gravity: EdgeAlert.TOP,
            backgroundColor: Colors.red);
      }
    }
  }

  Future apiqgetdistricts() async {
    if (amphures["id"] != null) {
      try {
        var obj = {"idamphures": (amphures["id"]).toString()};
        var _obj = jsonEncode(obj);
        var response = await http.post('$api/server/student/districts',
            headers: {
              'content-type': 'application/json',
            },
            body: _obj);
        var res = jsonDecode(response.body);
        var status = res["status"];
        if (status) {
          setState(() {
            listdistricts = res['result'] as List;
            listdistricts.forEach((item) {
              itemsListdistricts.add(DropdownMenuItem(
                child: Text(item["name_th"], style: hintStyle),
                value: {'districts': item["name_th"], 'post': item["zip_code"]},
              ));
            });
          });
        }
      } catch (e) {
        EdgeAlert.show(context,
            title: 'กรุณาลองใหม่',
            description: '$e',
            gravity: EdgeAlert.TOP,
            backgroundColor: Colors.red);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(5.0),
        child: ListView(
          children: <Widget>[
            Card(
              elevation: 7.0,
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    textTitle('ข้อมูลนักศึกษา'),
                    grades(),
                    prefixSTD(),
                    // inputData(
                    //     Icon(Icons.account_circle, color: indexColor),
                    //     'รหัสนักศึกษา',
                    //     'รหัสนักศึกษา',
                    //     idSTD,
                    //     TextInputType.number,
                    //     'กรุณากรอกรหัสนักศึกษา'),
                    inputData(
                        Icon(Icons.account_circle, color: indexColor),
                        'ชื่อจริง นักศึกษา',
                        'ชื่อจริง นักศึกษา',
                        firstnameSTD,
                        TextInputType.text,
                        'กรุณากรอกชื่อจริง'),
                    inputData(
                        Icon(Icons.account_circle, color: indexColor),
                        'นามสกุล นักศึกษา',
                        'นามสกุล นักศึกษา',
                        lastnameSTD,
                        TextInputType.text,
                        'กรุณากรอก นามสกุล'),
                    inputData(
                        Icon(Icons.phone_iphone, color: indexColor),
                        'เบอร์โทรศัพท์ นักศึกษา',
                        'เบอร์โทรศัพท์ นักศึกษา',
                        phoneSTD,
                        TextInputType.phone,
                        'กรุณากรอก เบอร์โทรศัพท์'),
                    // inputData(
                    //     Icon(Icons.account_circle, color: indexColor),
                    //     'รหัสประจำตัวประชาชน',
                    //     'รหัสประจำตัวประชาชน',
                    //     cardNumberSTD,
                    //     TextInputType.number,
                    //     'กรุณากรอก รหัสประจำตัวประชาชน'),
                    deparmentuser(),
                    textTitle('ข้อมูลผู้ปกครอง'),
                    prefixGD(),
                    inputData(
                        Icon(Icons.account_circle, color: indexColor),
                        'ชื่อจริง ผู้ปกครอง',
                        'ชื่อจริง ผู้ปกครอง',
                        firstnameGD,
                        TextInputType.text,
                        'กรุณากรอกชื่อจริง'),
                    inputData(
                        Icon(Icons.account_circle, color: indexColor),
                        'นามสกุล ผู้ปกครอง',
                        'นามสกุล ผู้ปกครอง',
                        lastnameGD,
                        TextInputType.text,
                        'กรุณากรอก นามสกุล'),
                    inputData(
                        Icon(Icons.phone_iphone, color: indexColor),
                        'เบอร์โทรศัพท์ ผู้ปกครอง',
                        'เบอร์โทรศัพท์ ผู้ปกครอง',
                        phoneGD,
                        TextInputType.phone,
                        'กรุณากรอก เบอร์โทรศัพท์'),
                    textTitle('ที่อยู่ปัจจุบัน'),
                    inputAddress('บ้านเลขที่ :', 'หมู่ที่ :', 'กรอกข้อมูล',
                        'กรอกข้อมูล', numbersHome, villages),
                    inputAddress('ถนน :', 'ซอย :', 'กรอกข้อมูล', 'กรอกข้อมูล',
                        road, alley),
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
                      child: searchItemsprovince(),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
                      child: searchItemsamphures(),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
                      child: searchItemsdistricts(),
                    ),
                    buttonSave(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget searchItemsprovince() {
    return SearchableDropdown.single(
      items: itemsListprovince,
      value: selectedValueprovince,
      label: Container(
          child: Text(
        "จังหวัด",
        style: TextStyle(
            fontSize: 16, color: Colors.grey[700], fontFamily: 'Mali'),
      )),
      hint: Text(
        "กรุณาเลือก จังหวัด",
        style: TextStyle(color: Colors.red, fontFamily: 'Mali'),
      ),
      searchHint: "Select Province",
      onChanged: (value) {
        setState(() {
          if (value != null) {
            province = value;
            apiqgetamphures();
          } else {
            itemsListamphures = [];
            itemsListdistricts = [];
            amphures.clear();
            districts.clear();
          }
        });
      },
      dialogBox: true,
      isExpanded: true,
    );
  }

  Widget searchItemsamphures() {
    return SearchableDropdown.single(
      items: itemsListamphures,
      value: selectedValueamphures,
      label: Container(
          child: Text(
        "อำเภอ",
        style: TextStyle(
            fontSize: 16, color: Colors.grey[700], fontFamily: 'Mali'),
      )),
      hint: Text(
        "กรุณาเลือก อำเภอ",
        style: TextStyle(color: Colors.red, fontFamily: 'Mali'),
      ),
      searchHint: "Select Amphures",
      onChanged: (value) {
        setState(() {
          if (value != null) {
            amphures = value;
            apiqgetdistricts();
          } else {
            itemsListdistricts = [];
            districts.clear();
          }
        });
      },
      dialogBox: true,
      isExpanded: true,
    );
  }

  Widget searchItemsdistricts() {
    return SearchableDropdown.single(
      items: itemsListdistricts,
      value: selectedValuedistricts,
      label: Container(
          child: Text(
        "ตำบล",
        style: TextStyle(
            fontSize: 16, color: Colors.grey[700], fontFamily: 'Mali'),
      )),
      hint: Text(
        "กรุณาเลือก ตำบล",
        style: TextStyle(color: Colors.red, fontFamily: 'Mali'),
      ),
      searchHint: "Select Districts",
      onChanged: (value) {
        setState(() {
          if (value != null) {
            districts = value;
          }
        });
      },
      dialogBox: true,
      isExpanded: true,
    );
  }

  Widget buttonSave() {
    return Container(
      height: 55.0,
      margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
      child: RaisedButton(
        color: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Text(
          'SAVE',
          style: TextStyle(
              fontSize: 22.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Mali'),
        ),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            if (issaved) {
              apiAddstudent();
              hidekeyboard();
              setState(() {
                issaved = false;
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

  Widget inputAddress(
      String hint1,
      String hint2,
      String isEmpty1,
      String isEmpty2,
      TextEditingController controller1,
      TextEditingController controller2) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: controller1,
                style: hintStyle,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: hint1,
                  hintStyle: hintStyle,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: indexColor, width: 2),
                  ),
                ),
                // ignore: missing_return
                validator: (String value) {
                  if (controller2 == villages) {
                    if (value.isEmpty) {
                      return isEmpty1;
                    }
                    return null;
                  }
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: controller2,
                style: hintStyle,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: hint2,
                  hintStyle: hintStyle,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: indexColor, width: 2),
                  ),
                ),
                // ignore: missing_return
                validator: (String value) {
                  if (controller1 == numbersHome) {
                    if (value.isEmpty) {
                      return isEmpty1;
                    }
                    return null;
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget inputData(Icon icon, String hint, String label,
      TextEditingController controller, TextInputType type, String isEmpty) {
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        style: hintStyle,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: hintStyle,
          prefixIcon: icon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            borderSide: BorderSide(color: indexColor, width: 2),
          ),
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return isEmpty;
          }
          return null;
        },
      ),
    );
  }

  Widget grades() {
    return Container(
      margin: EdgeInsets.only(bottom: 15.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 10.0, left: 10.0),
              // padding: EdgeInsets.symmetric(horizontal: 10.0),
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
                        hint: Text("ระดับ", style: hintStyle),
                        // style: hintStyle,
                        value: currentSelectedgrade1,
                        isDense: true,
                        onChanged: (newValue) {
                          setState(() {
                            currentSelectedgrade1 = newValue;
                          });
                        },
                        items: _grade1.map((String value) {
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
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 10.0),
              // padding: EdgeInsets.symmetric(horizontal: 10.0),
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
                        hint: Text("ชั้นปี", style: hintStyle),
                        value: currentSelectedgrade2,
                        isDense: true,
                        onChanged: (newValue) {
                          setState(() {
                            currentSelectedgrade2 = newValue;
                          });
                        },
                        items: _grade2.map((String value) {
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
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 10.0),
              // padding: EdgeInsets.symmetric(horizontal: 10.0),
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
                        hint: Text("ห้อง", style: hintStyle),
                        value: currentSelectedgrade3,
                        isDense: true,
                        onChanged: (newValue) {
                          setState(() {
                            currentSelectedgrade3 = newValue;
                          });
                        },
                        items: _grade3.map((String value) {
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
            ),
          )
        ],
      ),
    );
  }

  Widget deparmentuser() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: indexColor, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
      height: 60.0,
      child: TextFormField(
        style: hintStyle,
        controller: userdeparment,
        enabled: false,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            borderSide: BorderSide(color: indexColor, width: 2),
          ),
        ),
      ),
    );
  }

  Widget prefixGD() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
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
                hint: Text("คำนำหน้าชื่อ", style: hintStyle),
                value: currentSelectedprefixGD,
                isDense: true,
                onChanged: (newValue) {
                  setState(() {
                    currentSelectedprefixGD = newValue;
                  });
                },
                items: _prefix.map((String value) {
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

  Widget prefixSTD() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
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
                hint: Text("คำนำหน้าชื่อ", style: hintStyle),
                value: currentSelectedprefixSTD,
                isDense: true,
                onChanged: (newValue) {
                  setState(() {
                    currentSelectedprefixSTD = newValue;
                  });
                },
                items: _prefix.map((String value) {
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

  Widget textTitle(String text) {
    return Container(
      margin: EdgeInsets.only(top: 20.0, bottom: 15.0, left: 20.0),
      child: Row(
        children: <Widget>[
          Text('*',
              style: TextStyle(
                color: Colors.red,
                fontSize: 25.0,
                fontFamily: 'Mali',
              )),
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

}
