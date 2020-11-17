import 'dart:convert';
import 'package:KABINBURI/sign_in.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:http/http.dart' as http;
import 'package:KABINBURI/style/connect_api.dart';
import 'package:KABINBURI/style/contsan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final confirmpassword = TextEditingController();
  bool signupsuccess = false;

  Future apiCkeckAccount() async {
    var client = http.Client();
    try {
      var _obj = {
        'firstname': firstname.text.trim(),
        'username': username.text.trim(),
      };
      print(_obj);
      var res = await client.post('$api/server/user/check-login', body: _obj);
      var data = json.decode(res.body);
      if (data["status"] == true) {
        apiSignup();
        return true;
      } else {
        EdgeAlert.show(context,
            title: 'กรุณาลองใหม่',
            description: 'ชื่อบัญชีนี้ถูกใช้ไปแล้วกรุณาลองใหม่ค่ะ...',
            gravity: EdgeAlert.TOP,
            backgroundColor: Colors.red);
      }
    } finally {
      client.close();
    }
  }

  Future apiSignup() async {
    var client = http.Client();
    var _obj = {
      'firstname': firstname.text.trim(),
      'lastname': lastname.text.trim(),
      'username': username.text.trim(),
      'password': password.text.trim(),
    };
    try {
      var res = await client.post('$api/server/user/signup-user', body: _obj);
      var data = json.decode(res.body);
      print(res.body);
      print(data["status"]);
      if (data["status"] == true) {
        EdgeAlert.show(context,
            description: 'สมัครผู้ใช้งานสำเร็จ',
            gravity: EdgeAlert.TOP,
            backgroundColor: Colors.green,
            icon: Icons.check_circle_outline);
        Future.delayed(new Duration(microseconds: 1500), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignInPage()),
          );
        });
        return true;
      } else {
        EdgeAlert.show(context,
            title: 'ERROR',
            description: 'กรุณาลองอีกครั้ง...',
            gravity: EdgeAlert.TOP,
            backgroundColor: Colors.red);
      }
      return false;
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
                        SizedBox(height: 20.0),
                        _inputTF(
                          'Confirm Password',
                          true,
                          confirmpassword,
                          TextInputType.number,
                          Icon(Icons.lock, color: Colors.white),
                          'Enter your Confirm Password',
                          'กรุณากรอก Confirm Password',
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
          hidekeyboard();
          if (password.text.trim() == confirmpassword.text.trim()) {
            apiCkeckAccount();
          } else {
            EdgeAlert.show(context,
                title: 'ERROR',
                description: 'กรุณาตรวจสอบรหัสผ่าน...',
                gravity: EdgeAlert.TOP,
                backgroundColor: Colors.red);
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
        onPressed: () {
          hidekeyboard();
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
