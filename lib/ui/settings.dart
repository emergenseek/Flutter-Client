import 'package:flutter/material.dart';

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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingsSOS()));
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

//////////////////////////////////////////////////////////////////////////////

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

//////////////////////////////////////////////////////////////////////////////

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

//////////////////////////////////////////////////////////////////////////////

class SettingsSOS extends StatefulWidget {
  @override
  SettingsSOSState createState() {
    return new SettingsSOSState();
  }
}

class SettingsSOSState extends State<SettingsSOS> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
                ListTile(
                  //leading: Icon(Icons.room),
                  //title: Text('Service Locator Options')
                )
              ],
            )));
  }
}

//////////////////////////////////////////////////////////////////////////////

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

//////////////////////////////////////////////////////////////////////////////

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
