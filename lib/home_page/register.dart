import 'dart:convert';
import 'package:KABINBURI/home_page/login.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:KABINBURI/style/connect_api.dart';
import 'package:KABINBURI/style/contsan.dart';
import 'package:flutter/material.dart';
import 'package:sweetalert/sweetalert.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool signupsuccess = false;

  Widget _inputTF(
    String text,
    bool obscure,
    TextEditingController controller,
    TextInputType type,
    Icon icon,
    String hintText,
    String isEmpty,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          text,
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            obscureText: obscure,
            controller: controller,
            keyboardType: type,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: icon,
              hintText: hintText,
              hintStyle: kHintTextStyle,
            ),
            validator: (String value) {
              if (value.isEmpty) {
                return isEmpty;
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSignuoBtn() {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'Sign Up',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            apiCkeckAccount().then((value) => {
                  if (value == true && signupsuccess == true)
                    {Navigator.of(context).pop()}
                });
          }
        },
      ),
    );
  }

  Widget _buildBlackBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      width: double.infinity,
      child: OutlineButton(
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        borderSide: BorderSide(color: Colors.white, width: 2.0),
        child: Text(
          'Login ',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  Future apiSignup() async {
    var client = http.Client();
    var _obj = {
      'firstname': firstname.text.trim(),
      'lastname': lastname.text.trim(),
      'username': username.text.trim(),
      'password': password.text.trim(),
    };
    var obj = jsonEncode(_obj);
    try {
      var response = await client.post('$api/signin', body: obj);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        if (data['status'] == true) {
          SweetAlert.show(context,
              subtitle: "สมัครผู้ใช้งานสำเร็จ", style: SweetAlertStyle.success);
          Future.delayed(new Duration(microseconds: 2500), () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          });

          return true;
        } else {
          SweetAlert.show(context,
              style: SweetAlertStyle.error, title: "กรุณาลองอีกครั้ง...");
        }
        return data;
      } else {
        throw Exception('Failed to load data');
      }
    } finally {
      client.close();
    }
  }

  Future apiCkeckAccount() async {
    var client = http.Client();
    try {
      var _obj = {
        'firstname': firstname.text.trim(),
        'username': username.text.trim(),
      };
      // var obj = jsonEncode(_obj);
      print(_obj);
      var response = await client.post('$api/checkuser', body: _obj);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        if (data["status"] == true) {
          apiSignup().then((value) => {
                if (value == true)
                  {
                    signupsuccess = true,
                  }
              });
          return true;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF73AEF5),
                        Color(0xFF61A4F1),
                        Color(0xFF478DE0),
                        Color(0xFF398AE5),
                      ],
                      stops: [0.1, 0.4, 0.7, 0.9],
                    ),
                  ),
                ),
                Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 60.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: 50.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 30.0),
                        _inputTF(
                          'Firstname',
                          false,
                          firstname,
                          TextInputType.text,
                          Icon(Icons.account_circle, color: Colors.white),
                          'Enter your Firstname',
                          'กรุณากรอก ชื่อจริง',
                        ),
                        SizedBox(height: 20.0),
                        _inputTF(
                          'Lastname',
                          false,
                          lastname,
                          TextInputType.text,
                          Icon(Icons.account_circle, color: Colors.white),
                          'Enter your Lastname',
                          'กรุณากรอก นามสกุล',
                        ),
                        SizedBox(height: 20.0),
                        _inputTF(
                          'Username',
                          false,
                          username,
                          TextInputType.text,
                          Icon(Icons.account_circle, color: Colors.white),
                          'Enter your Username',
                          'กรุณากรอก Username',
                        ),
                        SizedBox(height: 20.0),
                        _inputTF(
                          'Password',
                          true,
                          password,
                          TextInputType.number,
                          Icon(Icons.lock, color: Colors.white),
                          'Enter your Password',
                          'กรุณากรอก Password',
                        ),
                        SizedBox(height: 30.0),
                        _buildSignuoBtn(),
                        _buildBlackBtn(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
