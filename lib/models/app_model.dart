import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:EmergenSeek/services/auth.dart';
import 'package:EmergenSeek/models/sos_model.dart';
import 'package:EmergenSeek/models/lUpdates_model.dart';
import 'package:EmergenSeek/models/contacts_model.dart';
import 'package:EmergenSeek/models/profile_model.dart';


// Model representing universal state data for the entire application
class AppModel extends Model with SOSModel, ContactsModel, ProfileModel, lupdatesModel {
  AppModel({this.auth, this.userId, this.onSignedOut});

  BaseAuth auth;
  VoidCallback onSignedOut;
  String userId;

  // Key: latitude/longitude, Val: coordinate
  Map<String, double> currentLocation;

  void setAuth(BaseAuth auth){
    this.auth = auth;
  }

  void setSignOut(VoidCallback onSignedOut){
    this.onSignedOut = onSignedOut;
  }

  void setUserId(String userId){
    this.userId = userId;
  }

  BaseAuth getAuth(){
    return auth;
  }

  VoidCallback getSignOut(){
    return onSignedOut;
  }

  String getUserId(){
    return userId;
  }

  signOut() async {
    try {
      await auth.signOut();
      onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  Future updateCurrentPosition() async {
    currentLocation = await getCurrentLocation();
  }

  Map getCurrentLocation() {
    return currentLocation;
  }
}