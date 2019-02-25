import 'package:flutter/material.dart';
import 'nav_menu.dart';
import 'sos_quick_button.dart';

class ServiceLocatorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.blueGrey[400],
        drawer: NavMenu(),
        appBar: AppBar(
          title: Text("Service Locator"),
        ),
        body: Center(
          child: Text("Service Locator Page Placeholder"),
        ),
        floatingActionButton: QuickSOS());
  }
}
