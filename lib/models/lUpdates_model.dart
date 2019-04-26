import 'package:scoped_model/scoped_model.dart';
import 'package:EmergenSeek/services/geolocator.dart';
import 'package:EmergenSeek/services/api.dart';

mixin lupdatesModel on Model {
  String _userId;

  bool _sendUpdate = false;
  bool _primaryContacts = true;
  bool _secondaryContacts = false;
  bool _tertiaryContacts = false;
  bool _lPolling = false;
  String message = "Location Updates";
  bool val = true;

  Future sendUpdate(List coordinates) async {
    _sendUpdate = true;
    //List coordinates = await getCurrentLocation();
    sendUpdateSMS(coordinates, _userId);
  }

  void startLocationPolling(List coordinates) {
    locationPolling(coordinates, _userId);
  }

  Future lPoll(_lPolling) async {
    // setState(() {
    if (_lPolling) {
      message = "Location Updates On";
      val = true;
    } else {
      message = "Location Updates Off";
      val = false;
      _lPolling = false;
    }
  }

  setUpdatesUserId(String newUserId) {
    _userId = newUserId;
  }

  bool getPrimaryContacts() {
    return _primaryContacts;
  }

  bool getSecondaryContacts() {
    return _secondaryContacts;
  }

  bool getTertiaryContacts() {
    return _tertiaryContacts;
  }

  void togglePrimaryContacts() {
    _primaryContacts = !_primaryContacts;
    notifyListeners();
  }

  void toggleSecondaryContacts() {
    _secondaryContacts = !_secondaryContacts;
    notifyListeners();
  }

  void toggleTertiaryContacts() {
    _tertiaryContacts = !_tertiaryContacts;
    notifyListeners();
  }
}
