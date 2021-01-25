import 'dart:convert';
import 'package:KABINBURI/Administrator/main_admin.dart';
import 'package:KABINBURI/style/contsan.dart';
import 'package:KABINBURI/style/singout.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:http/http.dart' as http;
import 'package:KABINBURI/style/connect_api.dart';
import 'package:flutter/material.dart';

class AddAccounting extends StatefulWidget {
  AddAccounting({Key key}) : super(key: key);

  @override
  _AddAccountingState createState() => _AddAccountingState();
}

class _AddAccountingState extends State<AddAccounting> {
  final _formKey = GlobalKey<FormState>();
  var firstname = TextEditingController();
  var lastname = TextEditingController();
  var username = TextEditingController();
  var password = TextEditingController();
  var confirmpassword = TextEditingController();
  var selecteddeparment;
  var currentSelectedprefix;

  final _prefixGD = ["นาย", "นาง", "นางสาว"];

  final _deparment = [
    "แผนกวิชาคอมพิวเตอร์ธุรกิจ",
    "แผนกวิชาการบัญชี",
    "แผนกวิชาธุรกิจค้าปลีก",
    "แผนกวิชาช่างซ่อมบำรุง",
    "แผนกวิชาช่างยนต์",
    "แผนกวิชาช่างไฟฟ้ากำลัง",
    "แผนกวิชาช่างอิเล็กทรอนิกส์",
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: mainColor,
        padding: EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Card(
              child: Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      titleText(),
                      prefixUser(),
                      input('Firstname', false, firstname, TextInputType.text,
                          'กรุณากรอก ชื่อผู้ใช้'),
                      input('Lastname', false, lastname, TextInputType.text,
                          'กรุณากรอก นามสกุลผู้ใช้'),
                      input('Username', false, username, TextInputType.text,
                          'กรุณากรอก username'),
                      input('Password', true, password, TextInputType.number,
                          'กรุณากรอก password'),
                      input('Confirm Password', true, confirmpassword,
                          TextInputType.number, 'กรุณากรอก Confirm Password'),
                      daparment(),
                      buttonSave(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future apiAdduser() async {
    var iddeparment;
    if (selecteddeparment == "แผนกวิชาคอมพิวเตอร์ธุรกิจ") {
      iddeparment = 1;
    } else if (selecteddeparment == "แผนกวิชาการบัญชี") {
      iddeparment = 2;
    } else if (selecteddeparment == "แผนกวิชาช่างซ่อมบำรุง") {
      iddeparment = 3;
    } else if (selecteddeparment == "แผนกวิชาธุรกิจค้าปลีก") {
      iddeparment = 4;
    } else if (selecteddeparment == "แผนกวิชาช่างยนต์") {
      iddeparment = 5;
    } else if (selecteddeparment == "แผนกวิชาช่างไฟฟ้ากำลัง") {
      iddeparment = 6;
    } else if (selecteddeparment == "แผนกวิชาช่างอิเล็กทรอนิกส์") {
      iddeparment = 7;
    }
    var obj = {
      'prefix': currentSelectedprefix,
      'firstname': firstname.text.trim(),
      'lastname': lastname.text.trim(),
      'username': username.text.trim(),
      'password': password.text.trim(),
      'deparmentID': iddeparment,
    };
    var _obj = jsonEncode(obj);
    try {
      var res = await http.post('$api/server/user/signup-teacher',
          headers: {
            'content-type': 'application/json',
          },
          body: _obj);
      var data = json.decode(res.body);
      if (data['status'] == true) {
        EdgeAlert.show(context,
            title: 'เพิ่มบัญชีผู้ใช้สำเร็จ',
            gravity: EdgeAlert.TOP,
            backgroundColor: Colors.green,
            icon: Icons.check_circle_outline);
        pushRemove(context, MainAdminPage());
      }
      return data;
    } catch (e) {
      EdgeAlert.show(context,
          title: 'ERROR',
          description: '$e',
          gravity: EdgeAlert.TOP,
          backgroundColor: Colors.red);
    }
  }

  Future apiCkeckAccount() async {
    try {
      var obj = {
        'firstname': firstname.text.trim(),
        'username': username.text.trim(),
      };
      var _obj = jsonEncode(obj);
      var res = await http.post('$api/server/user/check-login',
          headers: {
            'content-type': 'application/json',
          },
          body: _obj);
      var data = json.decode(res.body);
      if (data["status"] == true) {
        apiAdduser();
        return true;
      } else {
        EdgeAlert.show(context,
            title: 'กรุณาลองใหม่',
            description: 'ชื่อบัญชีนี้ถูกใช้ไปแล้วกรุณาลองใหม่ค่ะ...',
            gravity: EdgeAlert.TOP,
            backgroundColor: Colors.red);
      }
    } catch (e) {
      EdgeAlert.show(context,
          title: 'กรุณาลองใหม่',
          description: '$e',
          gravity: EdgeAlert.TOP,
          backgroundColor: Colors.red);
    }
  }

  Widget prefixUser() {
    return Container(
      padding: EdgeInsets.only(left: 20.0, right: 25.0, top: 20.0),
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(18.0)),
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                icon: Icon(Icons.arrow_drop_down, color: indexColor),
                hint: Text("คำนำหน้าชื่อ", style: hintStyle),
                value: currentSelectedprefix,
                isDense: true,
                onChanged: (newValue) {
                  setState(() {
                    currentSelectedprefix = newValue;
                  });
                },
                items: _prefixGD.map((String value) {
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

  Widget buttonSave() {
    return Container(
      height: 50.0,
      margin: EdgeInsets.only(top: 30.0, bottom: 25.0),
      child: RaisedButton(
        color: Colors.blue,
        child: Text(
          'บันทึกข้อมูล',
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontFamily: 'Mali',
          ),
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        onPressed: () {
          hidekeyboard();
          if (password.text.trim() == confirmpassword.text.trim()) {
            apiCkeckAccount();
          } else {
            EdgeAlert.show(context,
                title: 'กรุณาลองใหม่',
                description: 'กรุณาตรวจสอบรหัสผ่านใหม่ค่ะ...',
                gravity: EdgeAlert.TOP,
                backgroundColor: Colors.red);
          }
        },
      ),
    );
  }

  Widget daparment() {
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                icon: Icon(Icons.arrow_drop_down),
                hint: Text("กรุณาเลือกแผนก", style: hintStyle),
                value: selecteddeparment,
                isDense: true,
                onChanged: (newValue) {
                  setState(() {
                    selecteddeparment = newValue;
                  });
                },
                items: _deparment.map((String value) {
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

  Widget input(String labelText, bool obscure, TextEditingController controller,
      TextInputType type, String isEmpty) {
    return Container(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      child: TextFormField(
        style: hintStyle,
        obscureText: obscure,
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          labelStyle: hintStyle,
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return isEmpty;
          }
          return null;
        },
        // onChanged: (text)  {
        //       controller.text = controller1.text;
        //     },
      ),
    );
  }

  Widget titleText() {
    return Container(
      margin: EdgeInsets.only(top: 12.0, left: 12.0),
      child: Row(
        children: <Widget>[
          Text(
            '*',
            style: TextStyle(
                color: Colors.red,
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Mali'),
          ),
          Text(
            'เพิ่มบัญชีผู้ใช้',
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Mali'),
          ),
        ],
      ),
    );
  }
}
