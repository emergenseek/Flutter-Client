import 'package:flutter/material.dart';
import 'package:flutter_app/screens/about.dart';
import 'package:flutter_app/screens/contacts.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:flutter_app/screens/location_updates.dart';
import 'package:flutter_app/screens/profile.dart';
import 'package:flutter_app/screens/service_locator.dart';
import 'package:flutter_app/screens/sos.dart';

class NavMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
            color: Theme.of(context).primaryColor,
            child: ListTileTheme(
                iconColor: Colors.white,
                textColor: Colors.white,
                child: ListView(padding: EdgeInsets.zero, children: <Widget>[
                  Container(
                    height: 170.0,
                    child: DrawerHeader(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: [
                              0.0,
                              0.2,
                              0.4,
                              0.6,
                              0.8,
                              1.0,
                            ],
                            colors: [
                              Colors.blue[200],
                              Colors.blue[100],
                              Colors.blue[50],
                              Colors.blue[50],
                              Colors.blue[100],
                              Colors.blue[200],
                            ]),
                        color: Theme.of(context).accentColor,
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
                        Navigator.of(context).pushNamed('/home');
                      }),
                  ListTile(
                      leading: Icon(Icons.room),
                      title: Text("Service Locator"),
                      onTap: () {
                        Navigator.of(context).pushNamed('/service_locator');
                      }),
                  ListTile(
                      leading: Icon(Icons.notifications),
                      title: Text("Location Updates"),
                      onTap: () {
                        Navigator.of(context).pushNamed('/location_updates');
                      }),
                  ListTile(
                      leading: Icon(Icons.error),
                      title: Text("S.O.S."),
                      onTap: () {
                        Navigator.of(context).pushNamed('/sos');
                      }),
                  ListTile(
                      leading: Icon(Icons.person),
                      title: Text("Profile"),
                      onTap: () {
                        Navigator.of(context).pushNamed('/profile');
                      }),
                  ListTile(
                      leading: Icon(Icons.people),
                      title: Text("Contacts"),
                      onTap: () {
                        Navigator.of(context).pushNamed('/contacts');
                      }),
                  ListTile(
                      leading: Icon(Icons.info),
                      title: Text("About"),
                      onTap: () {
                        Navigator.of(context).pushNamed('/about');
                      }),
                ]))));
  }
}
