import 'package:flutter/material.dart';
import 'package:flutter_app/screens/sos.dart';

class QuickSOS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      tooltip: 'S.O.S.',
      backgroundColor: Theme.of(context).accentColor,
      child:
          Icon(Icons.error_outline, color: Colors.blue[200], size: 35.0),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SOSPage()));
      },
    );
  }
}
