import 'package:scoped_model/scoped_model.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:EmergenSeek/services/contact_services.dart';

mixin ContactsModel on Model {
  Iterable<Contact> _contacts;

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
}