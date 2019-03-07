import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:flutter_app/screens/service_locator.dart';
import 'package:flutter_app/screens/location_updates.dart';
import 'package:flutter_app/screens/sos.dart';
import 'package:flutter_app/screens/profile.dart';
import 'package:flutter_app/screens/contacts.dart';
import 'package:flutter_app/screens/about.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EmergenSeek Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.blueGrey[900],
          accentColor: Colors.grey[900],
          fontFamily: 'Montserrat',
          textTheme: TextTheme(
            headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold, color: Colors.white),
            title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic, color: Colors.white),
            body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind', color: Colors.white),
          )),
      home: HomePage(),
      routes: <String, WidgetBuilder> {
        '/home': (BuildContext context) => HomePage(),
        '/service_locator': (BuildContext context) => ServiceLocatorPage(),
        '/location_updates': (BuildContext context) => LocationUpdatesPage(),
        '/sos': (BuildContext context) => SOSPage(),
        '/profile': (BuildContext context) => ProfilePage(),
        '/contacts': (BuildContext context) => ContactsPage(),
        '/about': (BuildContext context) => AboutPage(),
      },
    );
  }
}
