import 'package:scoped_model/scoped_model.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:EmergenSeek/services/contact_services.dart';
import 'package:EmergenSeek/services/api.dart' as api;

mixin ContactsModel on Model {
  String _userId;

  Iterable<Contact> _deviceContacts;
  Iterable<dynamic> _registeredContacts;
  Map<String, int> tierMap = new Map<String, int>();

  bool _showUnregistered = true;
  bool _showTier1 = true;
  bool _showTier2 = true;
  bool _showTier3 = true;

  // Retrieves contacts stored on the device
  Iterable<Contact> getDeviceContacts() {
    refreshContacts();
    return _deviceContacts;
  }

  // Retrieves contacts registered in the backend
  Iterable<dynamic> getRegisteredContacts() {
    refreshContacts();
    return _registeredContacts;
  }

  // Retrieves tier map for device contacts
  Map<String, int> getContactTiers() {
    refreshContacts();
    return tierMap;
  }

  // Return true once request has been fulfilled
  // signals FutureBuilder to build
  Future<bool> refreshContacts() async {
    // Retrieve contacts from device
    _deviceContacts = await retrieveContacts();
    // Retrieve registered contact data from DB
    var profile = await api.getProfile(_userId);
    _registeredContacts = profile.contacts;

    // Update local tier map with new contacts and set their tier to "unregistered"
    _deviceContacts.forEach((contact) => tierMap.putIfAbsent(contact.identifier, () => 0));

    // Update device contacts list according to current tier filters
    List<Contact> _contactsList = _deviceContacts.toList();
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
    _deviceContacts = _contactsList;

    // Update registered contacts list according to current tier filters
    List<dynamic> _registeredContactsList = _registeredContacts.toList();
    if(!_showUnregistered){
      _registeredContactsList.removeWhere((contact) => contact["tier"] == 0);
    }
    if(!_showTier1){
      _registeredContactsList.removeWhere((contact) => contact["tier"] == 1);
    }
    if(!_showTier2){
      _registeredContactsList.removeWhere((contact) => contact["tier"] == 2);
    }
    if(!_showTier3){
      _registeredContactsList.removeWhere((contact) => contact["tier"] == 3);
    }
    _registeredContacts = _registeredContactsList;

    return true;
  }

  void addNewContact(Contact contact, tier){
    Iterable<String> name = contact.displayName.split(" ");
    String firstName = name.elementAt(0);
    String lastName = name.elementAt(1);
    String phoneNumber = contact.phones.first.value;
    // Register contact info with backend
    api.addNewContact(phoneNumber, "sister", firstName, lastName, "test_email", tier, _userId);
    // Update local tier map with new contact tier
    tierMap[contact.identifier] = tier;
  }

  void updateTier(dynamic contact, tier) {
    //String phoneNumber = contact.phones.first.value;
    String phoneNumber = contact["phone_number"];
    // Update contact tier with backend
    api.updateContactTier(phoneNumber, tier, _userId);
    // Update local tier map with new contact tier
    //tierMap[contact.identifier] = tier;
  }

  bool getShowUnregistered() {return _showUnregistered;}
  bool getShowTier1() {return _showTier1;}
  bool getShowTier2() {return _showTier2;}
  bool getShowTier3() {return _showTier3;}

  setContactsUserId(String newUserId) { _userId = newUserId; }

  void toggleUnregistered() {_showUnregistered = !_showUnregistered;}
  void toggleTier1() {_showTier1 = !_showTier1;}
  void toggleTier2() {_showTier2 = !_showTier2;}
  void toggleTier3() {_showTier3 = !_showTier3;}

}