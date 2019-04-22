import 'package:flutter/material.dart';
import 'package:EmergenSeek/screens/login_page.dart';
import 'package:EmergenSeek/services/auth.dart';
import 'package:EmergenSeek/screens/initial_profile.dart';
import 'package:EmergenSeek/screens/home.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:EmergenSeek/models/app_model.dart';

// Manager widget for directing the user to the appropriate page upon
// logging in or out
class RootPage extends StatefulWidget {
  RootPage({this.auth});

  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

enum ProfileStatus {
  NOT_DETERMINED,
  NOT_CREATED,
  CREATED,
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  ProfileStatus profileStatus = ProfileStatus.NOT_DETERMINED;
  String _userId = "";

  @override
  void initState() {
    super.initState();
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _userId = user?.uid;
        }
        authStatus =
            user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    });
  }

  void _onLoggedIn() {
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        _userId = user.uid.toString();
      });
    });
    setState(() {
      authStatus = AuthStatus.LOGGED_IN;
    });
  }

  void _onProfileCreated() {
    setState(() {
      profileStatus = ProfileStatus.CREATED;
    });
  }

  void _onSignedOut() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      profileStatus = ProfileStatus.NOT_DETERMINED;
      _userId = "";
    });
  }

  Widget _buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(builder: (context, child, model) {
      // Set app model attributes using root values
      model.setAuth(widget.auth);
      model.setSignOut(_onSignedOut);
      model.setUserId(_userId);

      // Route user to login or home page depending on authentication status
      switch (authStatus) {
        case AuthStatus.NOT_DETERMINED:
          return _buildWaitingScreen();
          break;
        case AuthStatus.NOT_LOGGED_IN:
          return new LoginPage(
            auth: widget.auth,
            onSignedIn: _onLoggedIn,
          );
          break;
        case AuthStatus.LOGGED_IN:
          return FutureBuilder(
            future: model.checkForUser(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (profileStatus == ProfileStatus.NOT_DETERMINED && snapshot.data == false) {
                  return new InitialProfilePage(
                    auth: widget.auth,
                    onProfileCreated: _onProfileCreated,
                  );
                }
                else if (_userId.length > 0 && _userId != null) {
                  return new HomePage(
                    userId: _userId,
                    auth: widget.auth,
                    onSignedOut: _onSignedOut,
                  );
                }
                else{
                  return _buildWaitingScreen();
                }
              }
              else{
                return _buildWaitingScreen();
              }
            });
          break;
        default:
          return _buildWaitingScreen();
      }
    });
  }
}
