import 'package:KABINBURI/Administrator/add_user_teacher.dart';
import 'package:KABINBURI/Administrator/dashboard.dart';
import 'package:KABINBURI/Administrator/list_data_delete.dart';
import 'package:KABINBURI/Administrator/profile.dart';
import 'package:KABINBURI/style/contsan.dart';
import 'package:flutter/material.dart';

class MainAdminPage extends StatefulWidget {
  MainAdminPage({Key key}) : super(key: key);

  @override
  _MainAdminPageState createState() => _MainAdminPageState();
}

class _MainAdminPageState extends State<MainAdminPage> {
  int _pageIndex = 0;

  // ignore: missing_return
  Widget pageIndex(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return HomePage();
        break;
      case 1:
        return AddAccounting();
        break;
      case 2:
        return ListDataDeletePage();
        break;
      case 3:
        return ProflieAdmin();
        break;
      default:
        return HomePage();
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
          hidekeyboard();
          setState(() {
            _pageIndex = value;
          });
        },
      ),
    );
  }
}
