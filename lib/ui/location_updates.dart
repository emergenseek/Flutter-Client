import 'package:flutter/material.dart';
import 'nav_menu.dart';
import 'sos_quick_button.dart';

class LocationUpdatesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.blueGrey[400],
        drawer: NavMenu(),
        appBar: AppBar(
          title: Text("Location Updates"),
        ),
        body: Center(
          child: Text("Location Updates Page Placeholder"),
        ),
        floatingActionButton: QuickSOS());
  }
}
