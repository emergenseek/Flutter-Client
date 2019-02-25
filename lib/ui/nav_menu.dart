import 'package:flutter/material.dart';
import 'about.dart';
import 'contacts.dart';
import 'home.dart';
import 'location_updates.dart';
import 'profile.dart';
import 'service_locator.dart';
import 'sos.dart';

class NavMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
            color: Colors.blueGrey[400],
            child: ListView(padding: EdgeInsets.zero, children: <Widget>[
              Container(
                height: 170.0,
                child: DrawerHeader(
                  //child: Text("Navigation Menu"),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [
                          0.1,
                          0.3,
                          0.5,
                          0.7,
                          0.9
                        ],
                        colors: [
                          Colors.lightBlue[200],
                          Colors.lightBlue[100],
                          Colors.lightBlue[50],
                          Colors.lightBlue[100],
                          Colors.lightBlue[200]
                        ]),
                    color: Colors.lightBlue[200],
                    image: DecorationImage(
                      image: ExactAssetImage('images/logo-text.png'),
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ),
              ListTile(
                  leading: Icon(Icons.home),
                  title: Text("Home"),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  }),
              ListTile(
                  leading: Icon(Icons.room),
                  title: Text("Service Locator"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ServiceLocatorPage()));
                  }),
              ListTile(
                  leading: Icon(Icons.notifications),
                  title: Text("Location Updates"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LocationUpdatesPage()));
                  }),
              ListTile(
                  leading: Icon(Icons.error),
                  title: Text("S.O.S."),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SOSPage()));
                  }),
              ListTile(
                  leading: Icon(Icons.person),
                  title: Text("Profile"),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProfilePage()));
                  }),
              ListTile(
                  leading: Icon(Icons.people),
                  title: Text("Contacts"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ContactsPage()));
                  }),
              ListTile(
                  leading: Icon(Icons.info),
                  title: Text("About"),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AboutPage()));
                  }),
            ])));
  }
}
