import 'package:flutter/material.dart';
import './ui/home.dart';

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
    );
  }
}
