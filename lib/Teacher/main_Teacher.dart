import 'package:KABINBURI/Teacher/add_student.dart';
import 'package:KABINBURI/Teacher/dashboard_teacher.dart';
import 'package:KABINBURI/Teacher/list_student.dart';
import 'package:KABINBURI/Teacher/profile_teacher.dart';
import 'package:KABINBURI/style/contsan.dart';
import 'package:flutter/material.dart';

class MainTeacherPage extends StatefulWidget {
  MainTeacherPage({Key key}) : super(key: key);

  @override
  _MainTeacherPageState createState() => _MainTeacherPageState();
}

class _MainTeacherPageState extends State<MainTeacherPage> {
  int _pageIndex = 0;

  Widget pageIndex(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return DashboardT();
        break;
      case 1:
        return AddNewStudent();
        break;
      case 2:
        return ListdataStudents();
        break;
      case 3:
        return ProfileTeacher();
        break;
      default:
        return DashboardT();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
        title: textAppBar(),
      ),
      body: pageIndex(_pageIndex),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            // ignore: deprecated_member_use
            title: Text(' '),
            icon: Icon(Icons.home, size: 30),
          ),
          BottomNavigationBarItem(
            // ignore: deprecated_member_use
            title: Text(' '),
            icon: Icon(Icons.person_add, size: 30),
          ),
          BottomNavigationBarItem(
            // ignore: deprecated_member_use
            title: Text(' '),
            icon: Icon(Icons.folder_shared, size: 30),
          ),
          BottomNavigationBarItem(
            // ignore: deprecated_member_use
            title: Text(' '),
            icon: Icon(Icons.list, size: 30),
          ),
        ],
        currentIndex: _pageIndex,
        onTap: (value) {
          setState(() {
            _pageIndex = value;
          });
        },
      ),
    );
  }
}
