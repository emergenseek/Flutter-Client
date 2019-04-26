import 'package:flutter/material.dart';
import 'package:EmergenSeek/screens/nav_menu.dart';
import 'package:EmergenSeek/screens/sos_quick_button.dart';
import 'package:EmergenSeek/screens/settings.dart';
import 'package:EmergenSeek/services/auth.dart';
import 'package:EmergenSeek/models/app_model.dart';
import 'package:scoped_model/scoped_model.dart';

class InitialProfilePage extends StatefulWidget {
  InitialProfilePage({this.auth, this.onProfileCreated});

  final BaseAuth auth;
  final VoidCallback onProfileCreated;

  @override
  _InitialProfilePageState createState() {
    return new _InitialProfilePageState();
  }
}

class _InitialProfilePageState extends State<InitialProfilePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.blueGrey[400],
        appBar: AppBar(
          title: Text("Create an Account"),
          actions: <Widget>[
          ],
        ),
        body: Center(
            child: ListView(
              children: <Widget>[
                _showProfileForm(),
              ],
            )
        ));
  }

  Widget _showProfileForm() {
    final _formKey = new GlobalKey<FormState>();
    return ScopedModelDescendant < AppModel > (
        builder: (context, child, model) => Container(
            padding: const EdgeInsets.fromLTRB(35.0, 0.0, 60.0, 20.0),
            child: Column(children: <Widget>[
              _showLogo(),
              new Padding(
                  padding: EdgeInsets.all(5.0)
              ),
              Form(
                key: _formKey,
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
                child: new Text("Submit", style: TextStyle(color: Colors.lightBlue[200])),
                color: Theme.of(context).accentColor,
                splashColor: Colors.blueGrey,
                onPressed: () {
                  if(_formKey.currentState.validate()){
                    _formKey.currentState.save();

                    Map<String, dynamic> profile = new Map<String, dynamic>();
                    profile["user_id"] = model.getUserId();
                    profile["first_name"] = model.getFirstName();
                    profile["last_name"] = model.getLastName();
                    profile["blood_type"] = model.getBloodType();
                    profile["age"] = model.getAge();
                    profile["primary_residence"] = model.getPrimaryResidence();
                    profile["phone_pin"] = model.getPhonePin();
                    profile["email_address"] = model.getEmail();
                    profile["phone_number"] = model.getPhoneNumber();

                    model.createNewUser(profile);
                    widget.onProfileCreated();
                  }
                },
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
              )
            ],)
        )
    );}
}

Widget _showLogo() {
  return new Hero(
      tag: 'hero',
      child: Padding(
          padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 90.0,
            child: Image.asset('images/logo-text.png'),
          )));
}