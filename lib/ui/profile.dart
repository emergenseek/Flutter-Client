import 'package:flutter/material.dart';
import 'nav_menu.dart';
import 'sos.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: NavMenu(),
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Center(
        child: Text("Profile Page Placeholder"),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'S.O.S.',
        child: Icon(Icons.error_outline, size: 35.0),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SOSPage()));
        },
      ),
    );
  }
}
