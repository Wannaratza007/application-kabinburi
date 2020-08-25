import 'package:KABINBURI/page_admin/screen_admin/dashboard.dart';
import 'package:KABINBURI/page_admin/screen_admin/list_datadelete.dart';
import 'package:KABINBURI/page_admin/screen_admin/new_account.dart';
import 'package:KABINBURI/page_admin/screen_admin/profile_admin.dart';
import 'package:KABINBURI/style/contsan.dart';
import 'package:flutter/material.dart';

class MainAdminPage extends StatefulWidget {
  MainAdminPage({Key key}) : super(key: key);

  @override
  _MainAdminPageState createState() => _MainAdminPageState();
}

class _MainAdminPageState extends State<MainAdminPage> {
  int _pageIndex = 0;

  Widget pageIndex(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return Dashboard();
        break;
      case 1:
        return AddAccount();
        break;
      case 2:
        return PageListDataDelete();
        break;
      case 3:
        return PageProfileAdmin();
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
            title: Text(''),
            icon: Icon(Icons.home, size: 30),
          ),
          BottomNavigationBarItem(
            title: Text(''),
            icon: Icon(Icons.person_add, size: 30),
          ),
          BottomNavigationBarItem(
            title: Text(''),
            icon: Icon(Icons.folder_shared, size: 30),
          ),
          BottomNavigationBarItem(
            title: Text(''),
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
