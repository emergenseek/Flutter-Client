import 'package:flutter/material.dart';
import 'package:EmergenSeek/screens/nav_menu.dart';
import 'package:EmergenSeek/screens/sos_quick_button.dart';
import 'package:EmergenSeek/screens/settings.dart';
import 'package:EmergenSeek/services/auth.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  @override
  _ProfilePageState createState() {
    return new _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.blueGrey[400],
        drawer: NavMenu(),
        appBar: AppBar(
          title: Text("Profile"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              tooltip: 'Settings',
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsProfile()));
              },
            )
          ],
        ),
        body: Center(
          child: ListView(
            children: <Widget>[
              _showProfileForm(),
            ],
          )
        ),
        floatingActionButton: QuickSOS());
  }

  Widget _showLogoutButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: new MaterialButton(
          elevation: 5.0,
          minWidth: 200.0,
          height: 42.0,
          color: Colors.white,
          child: new Text('Logout',
              style: new TextStyle(fontSize: 20.0, color: Colors.blue[200])),
          onPressed: _signOut,
        ));
  }

  Widget _showProfileForm() {
    return Container(
      padding: const EdgeInsets.fromLTRB(35.0, 50.0, 60.0, 20.0),
      child: Column(children: <Widget>[
        new CircleAvatar(
          radius: 70.0,
            backgroundColor: Colors.white,
            foregroundColor: Colors.blue[200],
            child: Text("DF", style: new TextStyle(fontSize: 65.0))),
        new Padding(
            padding: EdgeInsets.all(18.0)
        ),
        new TextFormField(
          maxLines: 1,
          autofocus: false,
          style: TextStyle(
            color: Colors.white,
          ),
          decoration: new InputDecoration(
              hintText: 'Name',
              icon: new Icon(
                Icons.face,
                color: Colors.blue[200],
              )),
          validator: (value) => value.isEmpty ? 'Name can\'t be empty' : null,
          //onSaved: (value) => _email = value,
        ),
        new TextFormField(
          maxLines: 1,
          autofocus: false,
          style: TextStyle(
            color: Colors.white,
          ),
          decoration: new InputDecoration(
              hintText: 'Address',
              icon: new Icon(
                Icons.home,
                color: Colors.blue[200],
              )),
          validator: (value) => value.isEmpty ? 'Name can\'t be empty' : null,
          //onSaved: (value) => _email = value,
        ),
        new TextFormField(
          maxLines: 1,
          autofocus: false,
          style: TextStyle(
            color: Colors.white,
          ),
          decoration: new InputDecoration(
              hintText: 'Age',
              icon: new Icon(
                Icons.calendar_today,
                color: Colors.blue[200],
              )),
          validator: (value) => value.isEmpty ? 'Name can\'t be empty' : null,
          //onSaved: (value) => _email = value,
        ),
        new TextFormField(
          maxLines: 1,
          autofocus: false,
          style: TextStyle(
            color: Colors.white,
          ),
          decoration: new InputDecoration(
              hintText: 'Blood Type',
              icon: new Icon(
                Icons.invert_colors,
                color: Colors.blue[200],
              )),
          validator: (value) => value.isEmpty ? 'Name can\'t be empty' : null,
          //onSaved: (value) => _email = value,
        ),
      ],)
    );
  }

  _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }
}
