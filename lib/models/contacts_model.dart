import 'package:scoped_model/scoped_model.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:EmergenSeek/services/contact_services.dart';
import 'package:EmergenSeek/services/api.dart' as api;

mixin ContactsModel on Model {
  Iterable<Contact> _contacts;
  Map<String, int> tierMap = new Map<String, int>();
  bool _showUnregistered = true;
  bool _showTier1 = true;
  bool _showTier2 = true;
  bool _showTier3 = true;

  Iterable<Contact> getContacts() {
    refreshContacts();
    return _contacts;
  }

  Map<String, int> getContactTiers() {
    refreshContacts();
    return tierMap;
  }

  // Return true once request has been fulfilled
  // signals FutureBuilder to build
  Future<bool> refreshContacts() async {
    // Retrieve contacts from device
    _contacts = await retrieveContacts();
    // Update local tier map with new contacts and set their tier to "unregistered"
    _contacts.forEach((contact) => tierMap.putIfAbsent(contact.identifier, () => 0));
    // Update contacts list according to current tier filters
    List<Contact> _contactsList = _contacts.toList();
    if(!_showUnregistered){
      _contactsList.removeWhere((contact) => tierMap[contact.identifier] == 0);
    }
    if(!_showTier1){
      _contactsList.removeWhere((contact) => tierMap[contact.identifier] == 1);
    }
    if(!_showTier2){
      _contactsList.removeWhere((contact) => tierMap[contact.identifier] == 2);
    }
    if(!_showTier3){
      _contactsList.removeWhere((contact) => tierMap[contact.identifier] == 3);
    }
    _contacts = _contactsList;

    return true;
  }

  void addNewContact(Contact contact, tier){
    String firstName = contact.displayName[0];
    String lastName = contact.displayName[1];
    String phoneNumber = contact.phones.first.value;
    // Register contact info with backend
    api.addNewContact(phoneNumber, "sister", firstName, lastName, "test_email", tier);
    // Update local tier map with new contact tier
    tierMap[contact.identifier] = tier;
  }

  void updateTier(Contact contact, tier) {
    String phoneNumber = contact.phones.first.value;
    // Update contact tier with backend
    api.updateContactTier(phoneNumber, tier);
    // Update local tier map with new contact tier
    tierMap[contact.identifier] = tier;
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