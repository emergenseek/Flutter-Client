import 'package:flutter/material.dart';
import 'nav_menu.dart';
import 'sos.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:EmergenSeek/models/app_model.dart';
import 'package:EmergenSeek/screens/settings.dart';

class LocationUpdatesPage extends StatefulWidget {
  @override
  LUpdatesSettingsState createState() {
    return new LUpdatesSettingsState();
  }
}

class LUpdatesSettingsState extends State<LocationUpdatesPage> {
  String message = "Location Polling";
  bool val = false;

  @override
  Future<void> lPoll(bool _lPolling) async {
    List coordinates = ScopedModel.of<AppModel>(context).getCurrentLocation();
    setState(() {
      if (_lPolling) {
        message = "Location Polling On";
        val = true;
        _lPolling = true;
        //List coordinates = await getCurrentLocation();
        //locationPolling(coordinates, );
        ScopedModel.of<AppModel>(context).startLocationPolling(coordinates);
      } else {
        message = "Location Polling Off";
        val = false;
        _lPolling = false;
      }
    });
  }

  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
      builder: (context, child, model) => Scaffold(
            backgroundColor: Colors.blueGrey[400],
            drawer: NavMenu(),
            appBar: AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              title: Text("Location Updates"),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LocationSettingsPage()));
                  },
                )
              ],
            ),
            //drawer: NavMenu(),
            body: ListTileTheme(
                textColor: Colors.white,
                iconColor: Colors.blue[200],
                child: ListView(
                  children: <Widget>[
                    CheckboxListTile(
                      title: Text("Primary Contacts"),
                      //subtitle: Text("Enable to include primary contacts in location update"),
                      activeColor: Colors.blue[200],
                      value: model.getPrimaryContacts(),
                      onChanged: (value) {
                        model.togglePrimaryContacts();
                      },
                    ),
                    CheckboxListTile(
                      title: Text("Secondary Contacts"),
                      //subtitle: Text("Enable to include secondary contacts in location update"),
                      activeColor: Colors.blue[200],
                      value: model.getSecondaryContacts(),
                      onChanged: (value) {
                        model.toggleSecondaryContacts();
                      },
                    ),
                    CheckboxListTile(
                      title: Text("Tertiary Contacts"),
                      //subtitle: Text("Enable to include tertiary contacts in location update"),
                      activeColor: Colors.blue[200],
                      value: model.getTertiaryContacts(),
                      onChanged: (value) {
                        model.toggleTertiaryContacts();
                      },
                    ),
                    new Text(" Location Updated @$now",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Ink(
                      decoration: ShapeDecoration(
                        color: Colors.white70,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                          icon: Icon(Icons.room),
                          iconSize: 250.0,
                          color: Colors.lightBlueAccent,
                          splashColor: Colors.blue,
                          highlightColor: Colors.blue,
                          //padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 23.0),
                          //new Text("Update sent"),
                          onPressed: () {
                            model.sendUpdate(model.getCurrentLocation());
                            updateNot();
                          }),
                    ),
                  ],
                )),
            floatingActionButton: FloatingActionButton(
              tooltip: 'S.O.S.',
              backgroundColor: Colors.blue[200],
              child: Icon(Icons.error_outline, size: 35.0, color: Colors.white),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SOSPage()));
              },
            ),
            bottomNavigationBar: new ButtonBar(
              children: <Widget>[
                Text(message),
                Switch(
                  value: val,
                  onChanged: (bool _lPolling) => lPoll(_lPolling),
                  activeColor: Colors.blue[200],
                ),
              ],
            ),
          ),
    );
  } //Widget

  var now = new DateTime(0000, 1, 1);

  void updateNot() {
    setState(() => now = new DateTime.now());
    //new Text ("Location Updated @ $now");
  }
} //LUpdatesSettings
