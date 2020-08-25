import 'package:KABINBURI/models/user_model.dart';
import 'package:KABINBURI/page_admin/main_admin.dart';
import 'package:KABINBURI/style/connect_api.dart';
import 'package:KABINBURI/style/contsan.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:sweetalert/sweetalert.dart';

// ignore: must_be_immutable
class AddAccount extends StatefulWidget {
  AddAccount({Key key}) : super(key: key);

  @override
  _AddAccountState createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {
  final _formKey = GlobalKey<FormState>();
  var firstname = TextEditingController();
  var lastname = TextEditingController();
  var username = TextEditingController();
  var password = TextEditingController();
  var phone = TextEditingController();
  List<UserModel> getusers = List();
  var selecteddeparment;
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
                      input(
                        'First name',
                        false,
                        firstname,
                        TextInputType.text,
                        'กรุณากรอก ชื่อผู้ใช้',
                      ),
                      input('Last name', false, lastname, TextInputType.text,
                          'กรุณากรอก นามสกุลผู้ใช้'),
                      input('User name', false, username, TextInputType.text,
                          'กรุณากรอก username'),
                      input('Password', true, password, TextInputType.number,
                          'กรุณากรอก password'),
                      input('Phone number', false, phone, TextInputType.number,
                          'กรุณากรอก เบอร์โทรศัพท์'),
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

  Future apiAdduser(
      firstname, lastname, username, password, phone, deparment) async {
    var client = http.Client();
    var _obj = {
      'firstname': firstname,
      'lastname': lastname,
      'username': username,
      'password': password,
      'phone': phone,
      'deparment': deparment,
    };
    print(_obj);
    try {
      var response = await client.post('$api/adduser', body: _obj);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        if (data['status'] == true) {
          SweetAlert.show(context,
              subtitle: "บันทึกข้อมูลสำเร็จ", style: SweetAlertStyle.success);
          Future.delayed(new Duration(milliseconds: 800), () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainAdminPage()),
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

  Future apiCkeckAccount(
      firstname, lastname, username, password, phone, deparment) async {
    var client = http.Client();
    try {
      var _obj = {
        'firstname': firstname,
        'username': username,
      };
      print(_obj);
      var response = await client.post('$api/checkuser', body: _obj);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        print(data["status"]);
        if (data["status"] == true) {
          apiAdduser(
            firstname,
            lastname,
            username,
            password,
            phone,
            deparment,
          );
        } else {
          SweetAlert.show(context,
              style: SweetAlertStyle.error,
              title: "กรุณาลองใหม่",
              subtitle: "ชื่อบัญชีนี้ถูกใช้ไปแล้วกรุณาลองใหม่ค่ะ...");
        }
      }
    } finally {
      client.close();
    }
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
              fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w700),
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            apiCkeckAccount(
              firstname.text.trim(),
              lastname.text.trim(),
              username.text.trim(),
              password.text.trim(),
              phone.text.trim(),
              selecteddeparment,
            );
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
                hint: Text("กรุณาเลือกแผนก"),
                value: selecteddeparment,
                isDense: true,
                onChanged: (newValue) {
                  setState(() {
                    selecteddeparment = newValue;
                  });
                  print(selecteddeparment);
                },
                items: _deparment.map((String value) {
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

  Widget input(String labelText, bool obscure, TextEditingController controller,
      TextInputType type, String isEmpty) {
    return Container(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      child: TextFormField(
        obscureText: obscure,
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
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
            ),
          ),
          Text(
            'จัดการบัญชีผู้ใช้',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
