import 'package:flutter/material.dart';
import 'package:flutter_app/screens/nav_menu.dart';
import 'package:flutter_app/screens/sos_quick_button.dart';
import 'package:flutter_app/screens/settings.dart';

class ServiceLocatorPage extends StatefulWidget {
  @override
  _ServiceLocatorPageState createState() {
    return new _ServiceLocatorPageState();
  }
}

class _ServiceLocatorPageState extends State<ServiceLocatorPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.blueGrey[400],
        drawer: NavMenu(),
        appBar: AppBar(
          title: Text("Service Locator"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              tooltip: 'Settings',
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsServiceLocator()));
              },
            )
          ],
        ),
        body: Center(
          child: Text("Service Locator Page Placeholder"),
        ),
        floatingActionButton: QuickSOS());
  }
}
