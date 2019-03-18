import 'package:flutter/material.dart';
import 'package:EmergenSeek/screens/home.dart';
import 'package:EmergenSeek/screens/service_locator.dart';
import 'package:EmergenSeek/screens/location_updates.dart';
import 'package:EmergenSeek/screens/sos.dart';
import 'package:EmergenSeek/screens/profile.dart';
import 'package:EmergenSeek/screens/contacts.dart';
import 'package:EmergenSeek/screens/about.dart';
import 'package:EmergenSeek/models/sos_model.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  final sos = SOSModel();

  runApp(
    ScopedModel<SOSModel>(
      model: sos,
      child: MyApp(),
    )
  );
}

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
