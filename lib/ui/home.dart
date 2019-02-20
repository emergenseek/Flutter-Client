import 'package:flutter/material.dart';
import 'nav_menu.dart';
import 'contacts.dart';
import 'service_locator.dart';
import 'sos.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavMenu(),
      appBar: AppBar(
        /*
        leading: IconButton(
          icon: Icon(Icons.menu),
          tooltip: 'EmergenSeek',
          onPressed: () {},
        ),*/
        title: Text('Home'),
      ),
      body: Center(child: HomeButtons()),
      floatingActionButton: FloatingActionButton(
        tooltip: 'S.O.S.',
        child: Icon(Icons.error_outline, size: 35.0),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => SOSPage()
          ));
        },
      ),
    );
  }
}

class HomeButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RawMaterialButton(
                    padding: EdgeInsets.all(15.0),
                    shape: new CircleBorder(),
                    fillColor: Colors.white70,
                    child: new Icon(
                      Icons.my_location,
                      color: Colors.lightBlueAccent,
                      size: 70.0,
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => ServiceLocatorPage()
                      ));
                    }),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(30.0),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <Widget>[
              RawMaterialButton(
                  padding: EdgeInsets.all(15.0),
                  shape: new CircleBorder(),
                  fillColor: Colors.white70,
                  child: new Icon(
                    Icons.error_outline,
                    color: Colors.lightBlueAccent,
                    size: 70.0,
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => SOSPage()
                    ));
                  }),
              RawMaterialButton(
                  padding: EdgeInsets.all(15.0),
                  shape: new CircleBorder(),
                  fillColor: Colors.white70,
                  child: new Icon(
                    Icons.person_outline,
                    color: Colors.lightBlueAccent,
                    size: 70.0,
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => ContactsPage()
                    ));
                  }),
            ])
          ],
        ));
  }

}