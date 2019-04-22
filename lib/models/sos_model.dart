import 'package:scoped_model/scoped_model.dart';
import 'package:EmergenSeek/services/api.dart';
import 'package:EmergenSeek/services/geolocator.dart';
import 'package:EmergenSeek/services/notifications.dart';

// Values representing the severity of the SOS alert
enum EmergencyTier { MILD, SEVERE }

// Model representing state data for the SOS feature
mixin SOSModel on Model {
  String _userId;

  bool _notifyUsers = false;
  bool _showLockscreenInfo = true;
  bool _sosActive = false;
  bool _sendTexts = true;
  bool _sendCalls = true;
  EmergencyTier _emergencyTier = EmergencyTier.MILD;
  Notifications _notifications = new Notifications();
  String _policeNumber;

  bool getSOSStatus() {
    return _sosActive;
  }
  bool getNotifyUsers() {
    return _notifyUsers;
  }
  bool getDisplayLockscreenInfo() {
    return _showLockscreenInfo;
  }
  bool getSendTexts() {
    return _sendTexts;
  }
  bool getSendCalls() {
    return _sendCalls;
  }
  String getPoliceNumber() {
    return _policeNumber;
  }

  setSOSUserId(String newUserId) { _userId = newUserId; }

  void setEmergencyTier(String severity){
    switch(severity){
      case 'MILD':
        _emergencyTier = EmergencyTier.MILD;
        break;
      case 'SEVERE':
        _emergencyTier = EmergencyTier.SEVERE;
        break;
    }
  }

  Future activateSOS() async {
    _sosActive = true;
    List coordinates = await pollCurrentLocation();

    // Retrieve contact info for police using location
    var emergencyInfo = await getEmergencyInfo(coordinates);
    _policeNumber = emergencyInfo.police;

    // Display local notification
    _notifications.displaySOSNotification();

    // Send API requests according to severity
    if(_emergencyTier == EmergencyTier.SEVERE && _sendCalls == true){
      sendCall(coordinates, _userId);
    }
    if(_sendTexts == true){
      _emergencyTier == EmergencyTier.SEVERE ? sendSMS(coordinates, 1, _userId) : sendSMS(coordinates, 2, _userId);
    }

    // Display personal info as a notification if user has enabled it
    if(_showLockscreenInfo == true){
      displayInfo();
    }
    // Inform [Model] to rebuild dependent widgets
    notifyListeners();
  }

  void deactivateSOS() {
    _sosActive = false;
    _notifications.cancelNotification();

    // Inform [Model] to rebuild dependent widgets
    notifyListeners();
  }

  Future displayInfo() async {
    var info = await getLockscreenInfo(_userId);
    _notifications.displayLockscreenNotification(info.first_name, info.last_name, info.blood_type, info.age);
  }

  void toggleNotifyUsers() {
    _notifyUsers = !_notifyUsers;
    notifyListeners();
  }

  void toggleDisplayLockscreenInfo() {
    _showLockscreenInfo = !_showLockscreenInfo;
    notifyListeners();
  }

  void toggleSendTexts(){
    _sendTexts = !_sendTexts;
    notifyListeners();
  }

  void toggleSendCalls(){
    _sendCalls = !_sendCalls;
    notifyListeners();
  }
}