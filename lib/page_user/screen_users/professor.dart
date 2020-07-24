import 'package:KABINBURI/style/contsan.dart';
import 'package:flutter/material.dart';

class Professor extends StatefulWidget {
  Professor({Key key}) : super(key: key);

  @override
  _ProfessorState createState() => _ProfessorState();
}

class _ProfessorState extends State<Professor> {
  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          tabSearch(),
          Container(
            height: 80.0,
            // padding: EdgeInsets.all(8.0),
            child: Card(
              elevation: 3.0,
              child: ListTile(
                leading: Icon(Icons.account_circle),
                title: Container(
                  child: Row(
                    children: <Widget>[
                      Text('First Name'),
                      SizedBox(width: 15.0),
                      Text('Last Name'),
                    ],
                  ),
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: 7.0),
                  child: Text('Deparment'),
                ),
                trailing: IconButton(icon: Icon(Icons.phone, color: Colors.green, size: 30.0), onPressed: (){}),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget tabSearch() {
    return Container(
      color: primaryColor,
      padding: EdgeInsets.all(5.0),
      child: Card(
        child: ListTile(
          leading: Icon(Icons.search),
          title: TextField(
            style: TextStyle(fontSize: 18.0),
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Search',
              border: InputBorder.none,
            ),
            // keyboardType: TextInputType.number,
            // inputFormatters: [
            //   BlacklistingTextInputFormatter(RegExp('[A-Z]')),
            //   WhitelistingTextInputFormatter(RegExp('[A-Z]')),
            //   LengthLimitingTextInputFormatter(5)s
            // ],
          ),
          trailing: IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              controller.clear();
            },
          ),
        ),
      ),
    );
  }

  Widget listdata() {
    return ListView.builder(
      itemCount: null,
      itemBuilder: (BuildContext context, int) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.account_circle),
            ),
            title: Text('data'),
            trailing: GestureDetector(
              child: IconButton(
                icon: Icon(Icons.phone),
                onPressed: () {},
              ),
            ),
          ),
        );
      },
    );
  }
}
