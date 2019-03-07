import 'package:flutter/material.dart';
import 'package:flutter_app/screens/nav_menu.dart';
import 'package:flutter_app/screens/sos_quick_button.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.blueGrey[400],
        drawer: NavMenu(),
        appBar: AppBar(
          title: Text("About EmergenSeek"),
        ),
        body: Center(
          child: Text("About Page Placeholder"),
        ),
        floatingActionButton: QuickSOS());
  }
}
