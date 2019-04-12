import 'package:flutter/material.dart';
import 'package:EmergenSeek/screens/nav_menu.dart';
import 'package:EmergenSeek/screens/sos_quick_button.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.blueGrey[400],
        drawer: NavMenu(),
        appBar: AppBar(
          title: Text("About EmergenSeek"),
        ),
        body: Container(
            padding: EdgeInsets.all(16.0),
            child: new Form(
              child: new ListView(
                shrinkWrap: true,
                children: <Widget>[
                  _showLogo(),
                  Text("Welcome to EmergenSeek, the app that helps you find assistance when you need it!", style: TextStyle(fontSize: 18.0)),
                  Text("", style: TextStyle(fontSize: 8.0)),
                  Text("EmergenSeek provides three key features:", style: TextStyle(fontSize: 18.0)),
                  Text("", style: TextStyle(fontSize: 8.0)),
                  Text("Service Locator - Seek out nearby emergency services in an accessible map", style: TextStyle(fontSize: 15.0)),
                  Text("", style: TextStyle(fontSize: 5.0)),
                  Text("Location Updates - Setup automatic updates sent to your contacts with information on your status and location", style: TextStyle(fontSize: 15.0)),
                  Text("", style: TextStyle(fontSize: 5.0)),
                  Text("SOS Alerts - Broadcast an emergency alert to your contacts and emergency services", style: TextStyle(fontSize: 15.0)),
                  Text("", style: TextStyle(fontSize: 8.0)),
                  Text("Contacts may be imported directly from your device within the contacts page", style: TextStyle(fontSize: 18.0)),
                  Text("", style: TextStyle(fontSize: 8.0)),
                  Text("In order to register a contact for alerts, you need to assign them to a contact tier", style: TextStyle(fontSize: 18.0)),
                  Text("", style: TextStyle(fontSize: 8.0)),
                  Text("Tier 1 - Recieves all alerts and updates", style: TextStyle(fontSize: 15.0)),
                  Text("", style: TextStyle(fontSize: 5.0)),
                  Text("Tier 1 - Recieves all alerts and less frequent updates", style: TextStyle(fontSize: 15.0)),
                  Text("", style: TextStyle(fontSize: 5.0)),
                  Text("Tier 1 - Recieves only severe alerts and no periodic updates", style: TextStyle(fontSize: 15.0)),
                ],
              ),
            )),
        floatingActionButton: QuickSOS());
  }
}

Widget _showLogo() {
  return new Hero(
      tag: 'hero',
      child: Padding(
          padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 90.0,
            child: Image.asset('images/logo-text.png'),
          )));
}
