import 'package:flutter/material.dart';
import 'package:EmergenSeek/screens/nav_menu.dart';
import 'package:EmergenSeek/screens/location_updates.dart';
import 'package:EmergenSeek/screens/service_locator.dart';
import 'package:EmergenSeek/screens/sos.dart';
import 'package:EmergenSeek/screens/settings.dart';
import 'package:EmergenSeek/util/animations.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavMenu(),
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SettingsHome()));
            },
          )
        ],
      ),
      body: Center(child: HomeButtons()),
    );
  }
}

class HomeButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blueGrey[400],
        //color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ShowUp(
              child: Text(
                'Welcome to EmergenSeek!',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w300),
              ),
              delay: 350
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 70.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RawMaterialButton(
                    padding: EdgeInsets.all(20.0),
                    elevation: 10.0,
                    shape: new CircleBorder(),
                    fillColor: Colors.white,
                    child: new Icon(
                      Icons.room,
                      color: Colors.blue[200],
                      size: 90.0,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ServiceLocatorPage()));
                    }),
                RawMaterialButton(
                    padding: EdgeInsets.all(20.0),
                    elevation: 10.0,
                    shape: new CircleBorder(),
                    fillColor: Colors.white,
                    child: new Icon(
                      Icons.notifications_none,
                      color: Colors.blue[200],
                      size: 90.0,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LocationUpdatesPage()));
                    }),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(32.0),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              RawMaterialButton(
                  padding: EdgeInsets.all(20.0),
                  elevation: 10.0,
                  shape: new CircleBorder(),
                  fillColor: Colors.white,
                  child: new Icon(
                    Icons.error_outline,
                    color: Colors.blue[200],
                    size: 90.0,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SOSPage()));
                  }),
            ])
          ],
        ));
  }
}
