import 'package:flutter/material.dart';
import 'package:flutter_app/screens/nav_menu.dart';
import 'package:flutter_app/screens/sos_quick_button.dart';
import 'package:flutter_app/screens/settings.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() {
    return new _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.blueGrey[400],
        drawer: NavMenu(),
        appBar: AppBar(
          title: Text("Profile"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              tooltip: 'Settings',
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsProfile()));
              },
            )
          ],
        ),
        body: Center(
          child: Text("Profile Page Placeholder"),
        ),
        floatingActionButton: QuickSOS());
  }
}
