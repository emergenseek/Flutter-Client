import 'package:flutter/material.dart';
import 'sos.dart';

class QuickSOS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      tooltip: 'S.O.S.',
      backgroundColor: Colors.white,
      child:
          Icon(Icons.error_outline, color: Colors.lightBlue[200], size: 35.0),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SOSPage()));
      },
    );
  }
}
