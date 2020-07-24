import 'package:KABINBURI/page_admin/screen_admin/dashboard.dart';
import 'package:KABINBURI/page_teacher/screen_teacher/list_student.dart';
import 'package:KABINBURI/page_teacher/screen_teacher/new_student.dart';
import 'package:KABINBURI/page_teacher/screen_teacher/profile_teacher.dart';
import 'package:KABINBURI/style/contsan.dart';
import 'package:flutter/material.dart';

class MainTeacherPass extends StatefulWidget {
  MainTeacherPass({Key key}) : super(key: key);

  @override
  _MainTeacherPassState createState() => _MainTeacherPassState();
}

class _MainTeacherPassState extends State<MainTeacherPass> {
  int _pageIndex = 0;

  Widget pageIndex(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return Dashboard();
        break;
      case 1:
        return AddDataStudent();
        break;
      case 2:
        return DataStudent();
        break;
      case 3:
        return PageProfileTeacher();
        break;
      default:
        return Dashboard();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: pageIndex(_pageIndex),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            title: Text(' '),
            icon: Icon(Icons.home, size: 30),
          ),
          BottomNavigationBarItem(
            title: Text(' '),
            icon: Icon(Icons.person_add, size: 30),
          ),
          BottomNavigationBarItem(
            title: Text(' '),
            icon: Icon(Icons.folder_shared, size: 30),
          ),
          BottomNavigationBarItem(
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
