import 'package:flutter/material.dart';
import 'nav_menu.dart';
import 'sos_quick_button.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.blueGrey[400],
        drawer: NavMenu(),
        appBar: AppBar(
          title: Text("Profile"),
        ),
        body: Center(
          child: Text("Profile Page Placeholder"),
        ),
        floatingActionButton: QuickSOS());
  }
}
