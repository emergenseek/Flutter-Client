import 'package:scoped_model/scoped_model.dart';

mixin lupdatesModel on Model{
  bool _sendUpdate = false;
  bool _primaryContacts = true;
  bool _secondaryContacts = false;
  bool _tertiaryContacts = false;

  bool sendUpdate(){
    return _sendUpdate;
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