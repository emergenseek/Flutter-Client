import 'package:scoped_model/scoped_model.dart';
import 'package:EmergenSeek/services/api.dart';
import 'package:EmergenSeek/services/geolocator.dart';
import 'package:EmergenSeek/services/notifications.dart';

// Values representing the severity of the SOS alert
enum EmergencyTier { MILD, SEVERE }

// Model representing state data for the SOS feature
mixin SOSModel on Model {
  bool _notifyUsers = false;
  bool _displayLockscreenInfo = true;
  bool _sosActive = false;
  bool _sendTexts = true;
  bool _sendCalls = true;
  EmergencyTier _emergencyTier = EmergencyTier.MILD;
  Notifications _notifications = new Notifications();

  bool getSOSStatus() {
    return _sosActive;
  }
  bool getNotifyUsers() {
    return _notifyUsers;
  }
  bool getDisplayLockscreenInfo() {
    return _displayLockscreenInfo;
  }
  bool getSendTexts() {
    return _sendTexts;
  }
  bool getSendCalls() {
    return _sendCalls;
  }

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
    List coordinates = await getCurrentLocation();

    // Display local notification
    _notifications.displaySOSNotification();

    // Send API requests according to severity
    if(_emergencyTier == EmergencyTier.SEVERE && _sendCalls == true){
      sendCall(coordinates);
    }
    if(_sendTexts == true){
      sendSMS(coordinates);
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
  void toggleNotifyUsers() {
    _notifyUsers = !_notifyUsers;
    notifyListeners();
  }
  void toggleDisplayLockscreenInfo() {
    _displayLockscreenInfo = !_displayLockscreenInfo;
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