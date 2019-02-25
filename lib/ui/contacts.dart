import 'package:flutter/material.dart';
import 'nav_menu.dart';
import 'sos_quick_button.dart';

class ContactsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.blueGrey[400],
        drawer: NavMenu(),
        appBar: AppBar(
          title: Text("Contacts"),
        ),
        body: Center(
          child: Text("Contacts Page Placeholder"),
        ),
        floatingActionButton: QuickSOS());
  }
}
