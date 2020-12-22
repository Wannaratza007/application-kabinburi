import 'dart:convert';
import 'package:KABINBURI/Administrator/main_Admin.dart';
import 'package:KABINBURI/Teacher/main_Teacher.dart';
import 'package:KABINBURI/model/user_model.dart';
import 'package:KABINBURI/sign_up.dart';
import 'package:KABINBURI/style/connect_api.dart';
import 'package:KABINBURI/style/contsan.dart';
import 'package:KABINBURI/style/singout.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final username = TextEditingController();
  final password = TextEditingController();
  bool islogin = false;

  Future checkLogin() async {
    var client = http.Client();
    print('username : ' + '  ' + username.text.trim());
    print('password : ' + '  ' + password.text.trim());
    var user = username.text.trim();
    var pass = password.text.trim();
    try {
      var _obj = {'username': user, 'password': pass.toString()};
      var response = await client.post('$api/server/user/login', body: _obj);
      var result = json.decode(response.body);
      if (result['status'] == true) {
        for (var i in result["result"]) {
          User usermodel = new User.fromJson(i);
          var status = usermodel.status;
          var pfn = await SharedPreferences.getInstance();
          pfn.setInt('id', usermodel.userId);
          pfn.setString('prefix', usermodel.prefix);
          pfn.setString('firstname', usermodel.firstname);
          pfn.setString('lastname', usermodel.lastname);
          pfn.setString('status', usermodel.status);
          pfn.setInt('deparmentID', usermodel.deparment);
          pfn.setString('deparment', usermodel.deparmentName);
          if (status == 'admin') {
            print('Administrator');
            pushRemove(context, MainAdminPage());
            setState(() {
              islogin = false;
              username.text = password.text = '';
            });
          } else if (status == 'teacher') {
            setState(() {
              islogin = false;
              username.text = password.text = '';
            });
            pushRemove(context, MainTeacherPage());
            print('Teacher');
          } else {
            EdgeAlert.show(context,
                title: 'ERROR',
                description: 'error 404!',
                gravity: EdgeAlert.TOP,
                backgroundColor: Colors.red);
          }
        }
      } else {
        EdgeAlert.show(context,
            title: 'ERROR',
            description: 'ชื่อผู้ใช้ หรือ รหัสผ่านไม่ถูกต้อง',
            gravity: EdgeAlert.TOP,
            backgroundColor: Colors.red);
        setState(() {
          islogin = false;
        });
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
                      vertical: 120.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: 50.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 30.0),
                        _buildEmailTF(),
                        SizedBox(
                          height: 30.0,
                        ),
                        _buildPasswordTF(),
                        _buildSignInWithText(),
                        _buildLoginBtn(),
                        _buildSignInWithText(),
                        // _buildSignupBtn(),
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

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Username',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            controller: username,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your Username',
              hintStyle: kHintTextStyle,
            ),
            validator: (String value) {
              if (value.isEmpty) {
                return 'กรุณากรอก username';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            controller: password,
            obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter your Password',
              hintStyle: kHintTextStyle,
            ),
            validator: (String value) {
              if (value.isEmpty) {
                return 'กรุณากรอก pasword';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
        onPressed: () {
          print("islogin");
          print(islogin);
          islogin == true
              ? EdgeAlert.show(context,
                  title: 'กรุณารอสักครู่ค่ะ...',
                  gravity: EdgeAlert.TOP,
                  backgroundColor: Colors.blue,
                  icon: Icons.check_circle_outline)
              : checkLogin();
          hidekeyboard();
          setState(() {
            islogin = true;
          });
        },
      ),
    );
  }

  Widget _buildSignInWithText() {
    return Column(
      children: <Widget>[
        SizedBox(height: 20.0),
      ],
    );
  }

  // ignore: unused_element
  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () {
        hidekeyboard();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
