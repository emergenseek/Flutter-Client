import 'package:flutter/material.dart';
import 'package:EmergenSeek/screens/nav_menu.dart';
import 'package:EmergenSeek/screens/sos_quick_button.dart';
import 'package:EmergenSeek/screens/settings.dart';
import 'package:EmergenSeek/services/auth.dart';
import 'package:EmergenSeek/models/app_model.dart';
import 'package:scoped_model/scoped_model.dart';

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
  final _formKey2 = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.blueGrey[400],
        drawer: NavMenu(),
        appBar: AppBar(
          title: Text("Profile"),
          actions: <Widget>[
            /*
            IconButton(
              icon: Icon(Icons.settings),
              tooltip: 'Settings',
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsProfile()));
              },
            )*/
          ],
        ),
        body: new FutureBuilder(
          future: ScopedModel.of<AppModel>(context).getProfileInfo(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.hasData) {
              return Center(
                  child: ListView(
                    children: <Widget>[
                      _showProfileForm(),
                    ],
                  )
              );
            } else {
              return Center(
                  child: Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 16.0),
                      child: CircularProgressIndicator()));
            }
          }
        ),
        floatingActionButton: QuickSOS());
  }

  Widget _showProfileForm() {
    return ScopedModelDescendant < AppModel > (
        builder: (context, child, model) => Container(
            padding: const EdgeInsets.fromLTRB(35.0, 50.0, 60.0, 20.0),
            child: Column(children: <Widget>[
              new CircleAvatar(
                  radius: 70.0,
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue[200],
                  child: Text(model.getFirstName()[0] + model.getLastName()[0], style: new TextStyle(fontSize: 65.0))),
              new Padding(
                  padding: EdgeInsets.all(18.0)
              ),
              Form(
                key: _formKey2,
                child: Column(
                  children: <Widget>[
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
                        initialValue: model.getFirstName() + ' ' + model.getLastName(),
                        validator: (value) =>
                        value.isEmpty
                            ? 'Name can\'t be empty'
                            : null,
                        onSaved: (value) {
                          model.setFirstName(value.split(" ")[0]);
                          model.setLastName(value.split(" ")[1]);
                        }
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
                      initialValue: model.getPrimaryResidence()["line1"] + ' ' +
                          model.getPrimaryResidence()["line2"] + ', ' +
                          model.getPrimaryResidence()["city"] + ' ' +
                          model.getPrimaryResidence()["state"],
                      validator: (value) =>
                      value.isEmpty
                          ? 'Name can\'t be empty'
                          : null,
                      onSaved: (value) {
                        //TODO: Parse each component of the address
                        /*
                  Map newAddress = Map<dynamic, dynamic>();
                  model.setPrimaryResidence(newAddress);
                  */
                      },
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
                      initialValue: model.getAge().toString(),
                      validator: (value) =>
                      value.isEmpty
                          ? 'Name can\'t be empty'
                          : null,
                      onSaved: (value) => model.setAge(int.parse(value)),
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
                      initialValue: model.getBloodType(),
                      validator: (value) =>
                      value.isEmpty
                          ? 'Name can\'t be empty'
                          : null,
                      onSaved: (value) => model.setBloodType(value),
                    ),
                    new TextFormField(
                      maxLines: 1,
                      autofocus: false,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: new InputDecoration(
                          hintText: 'Email',
                          icon: new Icon(
                            Icons.email,
                            color: Colors.blue[200],
                          )),
                      initialValue: model.getEmail(),
                      validator: (value) =>
                      value.isEmpty
                          ? 'Name can\'t be empty'
                          : null,
                      onSaved: (value) => model.setEmail(value),
                    ),
                    new TextFormField(
                      maxLines: 1,
                      autofocus: false,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: new InputDecoration(
                          hintText: 'Phone',
                          icon: new Icon(
                            Icons.phone,
                            color: Colors.blue[200],
                          )),
                      initialValue: model.getPhoneNumber(),
                      validator: (value) =>
                      value.isEmpty
                          ? 'Name can\'t be empty'
                          : null,
                      onSaved: (value) => model.setPhoneNumber(value),
                    ),
                  ],
                )
              ),
              new Padding(
                  padding: EdgeInsets.all(10.0)
              ),
              new RaisedButton(
                  child: new Text("Update", style: TextStyle(color: Colors.lightBlue[200])),
                  color: Theme.of(context).accentColor,
                  splashColor: Colors.blueGrey,
                  onPressed: () {
                    if(_formKey2.currentState.validate()) {
                      _formKey2.currentState.save();

                      Map<String, dynamic> profile = new Map<String, dynamic>();
                      profile["first_name"] = model.getFirstName();
                      profile["last_name"] = model.getLastName();
                      profile["blood_type"] = model.getBloodType();
                      profile["age"] = model.getAge();
                      profile["primary_residence"] = model.getPrimaryResidence();
                      profile["phone_pin"] = model.getPhonePin();
                      profile["email_address"] = model.getEmail();
                      profile["phone_number"] = model.getPhoneNumber();

                      model.updateProfileInfo(profile);
                    }
                  },
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
              )
            ],)
        )
    );}
}


