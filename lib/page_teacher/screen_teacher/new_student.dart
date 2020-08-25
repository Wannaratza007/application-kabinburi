import 'package:KABINBURI/page_teacher/main_teacher.dart';
import 'package:KABINBURI/style/connect_api.dart';
import 'package:KABINBURI/style/contsan.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:sweetalert/sweetalert.dart';

class AddDataStudent extends StatefulWidget {
  AddDataStudent({Key key}) : super(key: key);

  @override
  _AddDataStudentState createState() => _AddDataStudentState();
}

class _AddDataStudentState extends State<AddDataStudent> {
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
  var postcodes = TextEditingController();

  var currentSelectedprefixSTD;
  var currentSelectedprefixGD;
  var currentSelecteddeparment;
  var currentSelectedgrade1;
  var currentSelectedgrade2;
  var currentSelectedgrade3;

  final _deparment = [
    "การบัญชี",
    "คอมพิวเตอร์ธุรกิจ",
    "ช่างซ่อมบำรุง",
    "ช่างยนต์",
    "ธุรกิจค้าปลีก",
    "ช่างไฟฟ้ากำลัง",
    "ช่างอิเล็กทรอนิกส์",
  ];
  final _grade1 = ["ปวช.", "ปวส."];
  final _grade2 = ["1", "2", "3"];
  final _grade3 = ["1", "2", "3", "4", "5", "6"];
  final _prefixSTD = ["ด.ช.", "ด.ญ.", "นาย", "นาง", "นางสาว"];
  final _prefixGD = ["นาย", "นาง", "นางสาว"];
  final _formKey = GlobalKey<FormState>();

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
                    inputData(
                        Icon(Icons.phone_iphone, color: indexColor),
                        'รหัสประจำตัวประชาชน',
                        'รหัสประจำตัวประชาชน',
                        cardNumberSTD,
                        TextInputType.number,
                        'กรุณากรอก รหัสประจำตัวประชาชน'),
                    daparment(),
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
                        Icon(Icons.account_circle, color: indexColor),
                        'เบอร์โทรศัพ ผู้ปกครอง',
                        'เบอร์โทรศัพ ผู้ปกครอง',
                        phoneGD,
                        TextInputType.phone,
                        'กรุณากรอก เบอร์โทรศัพท์'),
                    textTitle('ที่อยู่ปัจจุบัน'),
                    inputAddress('บ้านเลขที่ :', 'หมู่ที่ :', 'กรอกข้อมูล',
                        'กรอกข้อมูล', numbersHome, villages),
                    inputAddress('ถนน :', 'รหัสไปรษณีย์ :', 'กรอกข้อมูล',
                        'กรอกข้อมูล', road, postcodes),
                    testDropdown('จังหวัด :'),
                    testDropdown('อำเภอ :'),
                    testDropdown('ตำบล :'),
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

  Future apiAddstudent(
    grades,
    prefixSTD,
    firstnameSTD,
    lastnameSTD,
    phoneSTD,
    cardNumberSTD,
    deparment,
    prefixGD,
    firstnameGD,
    lastnameGD,
    phoneGD,
    numberH,
    village,
    road,
    postcodes,
  ) async {
    var client = http.Client();
    var _obj = {
      'prefixSTD': prefixSTD,
      'firstNameSTD': firstnameSTD,
      'lastNameSTD': lastnameSTD,
      'phonesSTD': phoneSTD,
      'cardNumber': cardNumberSTD,
      'deparment': deparment,
      'studygroup': grades,
      'prefixGD': prefixGD,
      'firstNameGD': firstnameGD,
      'lastNameGD': lastnameGD,
      'phonesGD': phoneGD,
      'numberHomes': numberH,
      'village': village,
      'road': road,
      'post': postcodes
    };
    print(_obj);
    try {
      var response = await client.post('$api/insertStudent', body: _obj);
      if (response.statusCode == 200) {
        var data = convert.jsonDecode(response.body);
        if (data["status"] == true) {
          SweetAlert.show(context,
              subtitle: "บันทึกข้อมูลสำเร็จ", style: SweetAlertStyle.success);
          Future.delayed(new Duration(milliseconds: 800), () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainTeacherPass()),
            );
          });
        }
        return data;
      } else {
        throw Exception('Failed to load data');
      }
    } finally {
      client.close();
    }
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
              fontSize: 22.0, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            var grades = currentSelectedgrade1 +
                currentSelectedgrade2 +
                '/' +
                currentSelectedgrade3;
            print(grades);
            apiAddstudent(
              grades,
              currentSelectedprefixSTD,
              firstnameSTD.text.toString(),
              lastnameSTD.text.toString(),
              phoneSTD.text.toString(),
              cardNumberSTD.text.toString(),
              currentSelecteddeparment,
              currentSelectedprefixGD,
              firstnameGD.text.toString(),
              lastnameGD.text.toString(),
              phoneGD.text.toString(),
              numbersHome.text.toString(),
              villages.text.toString(),
              road.text.toString(),
              postcodes.text.toString(),
            );
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
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: hint1,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: indexColor, width: 2),
                  ),
                ),
                validator: (String value) {
                  if (value.isEmpty) {
                    return isEmpty1;
                  }
                  return null;
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: controller2,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: hint2,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: indexColor, width: 2),
                  ),
                ),
                validator: (String value) {
                  if (value.isEmpty) {
                    return isEmpty2;
                  }
                  return null;
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
        // style: TextStyle(fontSize: 16.0),
        controller: controller,
        // obscureText: obscure,
        keyboardType: type,
        decoration: InputDecoration(
          hintText: hint,
          // labelText: label,
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
                        hint: Text("ระดับ"),
                        value: currentSelectedgrade1,
                        isDense: true,
                        onChanged: (newValue) {
                          setState(() {
                            currentSelectedgrade1 = newValue;
                          });
                          print(currentSelectedgrade1);
                        },
                        items: _grade1.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
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
                        hint: Text("ชั้นปี"),
                        value: currentSelectedgrade2,
                        isDense: true,
                        onChanged: (newValue) {
                          setState(() {
                            currentSelectedgrade2 = newValue;
                          });
                          print(currentSelectedgrade2);
                        },
                        items: _grade2.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
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
                        hint: Text("ห้อง"),
                        value: currentSelectedgrade3,
                        isDense: true,
                        onChanged: (newValue) {
                          setState(() {
                            currentSelectedgrade3 = newValue;
                          });
                          print(currentSelectedgrade3);
                        },
                        items: _grade3.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
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

  Widget testDropdown(String text) {
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
      height: 60.0,
      child: TextField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            borderSide: BorderSide(color: indexColor, width: 2),
          ),
          labelText: text,
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
                hint: Text("คำนำหน้าชื่อ"),
                value: currentSelectedprefixGD,
                isDense: true,
                onChanged: (newValue) {
                  setState(() {
                    currentSelectedprefixGD = newValue;
                  });
                  print(currentSelectedprefixGD);
                },
                items: _prefixGD.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget daparment() {
    return Container(
      margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
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
                  hint: Text("กรุณาเลือกแผนก"),
                  value: currentSelecteddeparment,
                  isDense: true,
                  onChanged: (newValue) {
                    setState(() {
                      currentSelecteddeparment = newValue;
                    });
                    print(currentSelecteddeparment);
                  },
                  items: _deparment.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList()),
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
                hint: Text("คำนำหน้าชื่อ"),
                value: currentSelectedprefixSTD,
                isDense: true,
                onChanged: (newValue) {
                  setState(() {
                    currentSelectedprefixSTD = newValue;
                  });
                  print(currentSelectedprefixSTD);
                },
                items: _prefixSTD.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
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
          Text('*', style: TextStyle(color: Colors.red, fontSize: 25.0)),
          Text(
            text,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
