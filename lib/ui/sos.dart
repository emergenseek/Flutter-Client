import 'package:flutter/material.dart';
import 'nav_menu.dart';

class SOSPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        drawer: NavMenu(),
        appBar: AppBar(
          title: Text("S.O.S."),
        ),
        body: Center(
          child: Text("S.O.S. Page Placeholder"),
        )
    );
  }
}