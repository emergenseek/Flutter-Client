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
        child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text("Navigation Menu"),
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  image: DecorationImage(
                    image: AssetImage('images/logo.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              ListTile(
                  title: Text("Home"),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => HomePage()
                    ));
                  }),
              ListTile(
                  title: Text("Profile"),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => ProfilePage()
                    ));
                  }),
              ListTile(
                  title: Text("Contacts"),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => ContactsPage()
                    ));
                  }),
              ListTile(
                  title: Text("S.O.S."),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => SOSPage()
                    ));
                  }),
              ListTile(
                  title: Text("Service Locator"),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => ServiceLocatorPage()
                    ));
                  }),
              ListTile(
                  title: Text("Location Updates"),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => LocationUpdatesPage()
                    ));
                  }),
              ListTile(
                  title: Text("About"),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => AboutPage()
                    ));
                  }),
            ]));
  }
}