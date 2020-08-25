import 'package:KABINBURI/page_admin/screen_admin/dashboard.dart';
import 'package:KABINBURI/page_user/screen_users/professor.dart';
import 'package:KABINBURI/page_user/screen_users/profile_user.dart';
import 'package:KABINBURI/style/contsan.dart';
import 'package:flutter/material.dart';

class MainUsersPage extends StatefulWidget {
  MainUsersPage({Key key}) : super(key: key);

  @override
  _MainUsersPageState createState() => _MainUsersPageState();
}

class _MainUsersPageState extends State<MainUsersPage> {
  int _homepageindex = 0;

  Widget callPage(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return Dashboard();
        break;
      // case 1:
      //   return TimeLearn();
      //   break;
      case 1:
        return Professor();
        break;
      case 2:
        return PageProfileUser();
        break;
      default:
        return Dashboard();
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
      body: callPage(_homepageindex),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            title: Text(''),
            icon: Icon(Icons.home, size: 30),
          ),
          // BottomNavigationBarItem(
          //   title: Text(''),
          //   icon: Icon(Icons.date_range, size: 30),
          // ),
          BottomNavigationBarItem(
            title: Text(''),
            icon: Icon(Icons.assignment_ind, size: 30),
          ),
          BottomNavigationBarItem(
            title: Text(''),
            icon: Icon(Icons.list, size: 30),
          ),
        ],
        currentIndex: _homepageindex,
        onTap: (value) {
          setState(() {
            _homepageindex = value;
          });
        },
      ),
    );
  }
}
