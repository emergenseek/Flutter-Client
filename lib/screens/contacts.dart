import 'package:flutter/material.dart';
import 'package:EmergenSeek/screens/nav_menu.dart';
import 'package:EmergenSeek/screens/sos_quick_button.dart';
import 'package:EmergenSeek/screens/settings.dart';

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() {
    return new _ContactsPageState();
  }
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.blueGrey[400],
        drawer: NavMenu(),
        appBar: AppBar(
          title: Text("Contacts"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              tooltip: 'Settings',
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsContacts()));
              },
            )
          ],
        ),
        body: Center(
          child: Text("Contacts Page Placeholder"),
        ),
        floatingActionButton: QuickSOS());
  }
}
