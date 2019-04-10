import 'package:scoped_model/scoped_model.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:EmergenSeek/services/contact_services.dart';
import 'package:EmergenSeek/services/api.dart' as api;

mixin ContactsModel on Model {
  Iterable<Contact> _contacts;
  bool _showUnregistered = true;
  bool _showTier1 = true;
  bool _showTier2 = true;
  bool _showTier3 = true;

  getContacts() {
    refreshContacts();
    return _contacts;
  }

  // Return true once request has been fulfilled
  // signals FutureBuilder to build
  Future<bool> refreshContacts() async {
    _contacts = await retrieveContacts();
    return true;
  }

  addNewContact(firstName, lastName, phoneNumber, tier){
    api.addNewContact(phoneNumber, "sister", firstName, lastName, "test_email", tier);
  }

  updateTier() {

  }

  bool getShowUnregistered() {return _showUnregistered;}
  bool getShowTier1() {return _showTier1;}
  bool getShowTier2() {return _showTier2;}
  bool getShowTier3() {return _showTier3;}

  void toggleUnregistered() {_showUnregistered = !_showUnregistered;}
  void toggleTier1() {_showTier1 = !_showTier1;}
  void toggleTier2() {_showTier2 = !_showTier2;}
  void toggleTier3() {_showTier3 = !_showTier3;}

}