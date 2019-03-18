import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_app/models/sos_model.dart';

class SettingsHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text("Settings"),
        ),
        body: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.blue[200],
            child: ListView(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.room),
                  title: Text('Service Locator Settings'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingsServiceLocator()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.notifications),
                  title: Text('Location Updates Settings'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingsLocationUpdates()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.error),
                  title: Text('S.O.S. Alert Settings'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SettingsSOS()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Profile Settings'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingsProfile()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.people),
                  title: Text('Contact Settings'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingsContacts()));
                  },
                ),
              ],
            )));
  }
}

///////////////////////////Service Locator Settings///////////////////////////

class SettingsServiceLocator extends StatefulWidget {
  @override
  SettingsServiceLocatorState createState() {
    return new SettingsServiceLocatorState();
  }
}

class SettingsServiceLocatorState extends State<SettingsServiceLocator> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text("Service Locator Settings"),
        ),
        body: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.blue[200],
            child: ListView(
              children: <Widget>[
                ListTile(
                    //leading: Icon(Icons.room),
                    //title: Text('Service Locator Options')
                    )
              ],
            )));
  }
}

///////////////////////////Location Updates Settings///////////////////////////

class SettingsLocationUpdates extends StatefulWidget {
  @override
  SettingsLocationUpdatesState createState() {
    return new SettingsLocationUpdatesState();
  }
}

class SettingsLocationUpdatesState extends State<SettingsLocationUpdates> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text("Location Updates Settings"),
        ),
        body: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.blue[200],
            child: ListView(
              children: <Widget>[
                ListTile(
                    //leading: Icon(Icons.room),
                    //title: Text('Service Locator Options')
                    )
              ],
            )));
  }
}

///////////////////////////SOS Settings///////////////////////////

class SettingsSOS extends StatefulWidget {
  @override
  SettingsSOSState createState() {
    return new SettingsSOSState();
  }
}

class SettingsSOSState extends State<SettingsSOS> {
  Map<String, bool> values = {
    'displayInfo': false,
    'notifyUsers': false,
  };

  void onChanged(String key) {
    setState(() {
      values[key] = !values[key];
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<SOSModel>(
        builder: (context, child, sos) => Scaffold(
            backgroundColor: Theme.of(context).accentColor,
            appBar: AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              title: Text("S.O.S. Alert Settings"),
            ),
            body: ListTileTheme(
                textColor: Colors.white,
                iconColor: Colors.blue[200],
                child: ListView(
                  children: <Widget>[
                    CheckboxListTile(
                      title: Text("Display Lockscreen Info"),
                      subtitle: Text(
                          "Enable to display personalized information on"
                          " the lockscreen after activating SOS mode",
                          style: TextStyle(fontSize: 11.0)),
                      activeColor: Colors.blue[200],
                      value: sos.getDisplayLockscreenInfo(),//values['displayInfo'],
                      onChanged: (value) {
                        sos.toggleDisplayLockscreenInfo();//onChanged('displayInfo');
                      },
                    ),
                    CheckboxListTile(
                      title: Text("Notify Nearby Users"),
                      subtitle: Text(
                          "Enable to broadcast nearby EmergenSeek users"
                          " of your SOS alerts",
                          style: TextStyle(fontSize: 11.0)),
                      activeColor: Colors.blue[200],
                      value: sos.getNotifyUsers(),//values['notifyUsers'],
                      onChanged: (value) {
                        sos.toggleNotifyUsers();//onChanged('notifyUsers');
                      },
                    ),
                  ],
                ))));
  }
}

///////////////////////////Profile Settings///////////////////////////

class SettingsProfile extends StatefulWidget {
  @override
  SettingsProfileState createState() {
    return new SettingsProfileState();
  }
}

class SettingsProfileState extends State<SettingsProfile> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text("Profile Settings"),
        ),
        body: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.blue[200],
            child: ListView(
              children: <Widget>[
                ListTile(
                    //leading: Icon(Icons.room),
                    //title: Text('Service Locator Options')
                    )
              ],
            )));
  }
}

///////////////////////////Contact Settings///////////////////////////

class SettingsContacts extends StatefulWidget {
  @override
  SettingsContactsState createState() {
    return new SettingsContactsState();
  }
}

class SettingsContactsState extends State<SettingsContacts> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text("Contact Settings"),
        ),
        body: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.blue[200],
            child: ListView(
              children: <Widget>[
                ListTile(
                    //leading: Icon(Icons.room),
                    //title: Text('Service Locator Options')
                    )
              ],
            )));
  }
}
