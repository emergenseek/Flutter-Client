import 'package:flutter/material.dart';
import 'package:EmergenSeek/screens/nav_menu.dart';
import 'package:EmergenSeek/screens/sos_quick_button.dart';
import 'package:EmergenSeek/screens/settings.dart';

class LocationUpdatesPage extends StatefulWidget {
  @override
  _LocationUpdatesPageState createState() {
    return new _LocationUpdatesPageState();
  }
}

class _LocationUpdatesPageState extends State<LocationUpdatesPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.blueGrey[400],
        drawer: NavMenu(),
        appBar: AppBar(
          title: Text("Location Updates"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              tooltip: 'Settings',
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsLocationUpdates()));
              },
            )
          ],
        ),
        body: Center(
          child: Text("Location Updates Page Placeholder"),
        ),
        floatingActionButton: QuickSOS());
  }
}
