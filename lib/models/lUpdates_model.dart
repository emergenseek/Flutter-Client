import 'package:scoped_model/scoped_model.dart';
import 'package:EmergenSeek/services/geolocator.dart';
import 'package:EmergenSeek/services/api.dart';

mixin lupdatesModel on Model{
  bool _sendUpdate = false;
  bool _primaryContacts = true;
  bool _secondaryContacts = false;
  bool _tertiaryContacts = false;
  bool _lPolling = false;
  String message = "Location Updates";
  bool val = true;


  Future sendUpdate() async{
    _sendUpdate = true;
    List coordinates = await getCurrentLocation();
    sendUpdateSMS(coordinates);
  }

  Future lPoll(_lPolling) async {
    // setState(() {
    if (_lPolling) {
      message = "Location Updates On";
      val = true;
    }
    else {
      message = "Location Updates Off";
      val = false;
      _lPolling = false;
    }
  }

  bool getPrimaryContacts(){
    return _primaryContacts;
  }

  bool getSecondaryContacts(){
    return _secondaryContacts;
  }

  bool getTertiaryContacts(){
    return _tertiaryContacts;
  }

  void togglePrimaryContacts(){
    _primaryContacts = !_primaryContacts;
    notifyListeners();
  }

  void toggleSecondaryContacts(){
    _secondaryContacts = !_secondaryContacts;
    notifyListeners();
  }

  void toggleTertiaryContacts(){
    _tertiaryContacts = !_tertiaryContacts;
    notifyListeners();
  }

}