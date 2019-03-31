import 'package:flutter/material.dart';
import 'package:EmergenSeek/screens/home.dart';
import 'package:EmergenSeek/screens/service_locator.dart';
import 'package:EmergenSeek/screens/location_updates.dart';
import 'package:EmergenSeek/screens/sos.dart';
import 'package:EmergenSeek/screens/profile.dart';
import 'package:EmergenSeek/screens/contacts.dart';
import 'package:EmergenSeek/screens/about.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:EmergenSeek/services/auth.dart';
import 'package:EmergenSeek/screens/root.dart';
import 'package:EmergenSeek/models/app_model.dart';
import 'package:EmergenSeek/screens/login_page.dart';

void main() {
  runApp(
    ScopedModel<AppModel>(
      model: AppModel(),
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
      home: new RootPage(auth: new Auth()),//HomePage(),
      routes: <String, WidgetBuilder> {
        '/root': (BuildContext context) => RootPage(),
        '/login': (BuildContext context) => LoginPage(),
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
