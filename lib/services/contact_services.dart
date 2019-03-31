import 'package:contacts_service/contacts_service.dart';

// Get all contacts on the device
Future<Iterable<Contact>> retrieveContacts() async {
  Iterable<Contact> contacts = await ContactsService.getContacts();
  return contacts;
}

// Add a contact
// The contact must have a firstName / lastName to be successfully added
addContact(Contact newContact) async {
  await ContactsService.addContact(newContact);
}

// Delete a contact
// The contact must have a valid identifier
deleteContact(Contact contact) async {
  await ContactsService.deleteContact(contact);
}

// Update a contact
// The contact must have a valid identifier
updateContact(Contact contact) async {
  //await ContactsService.updateContact(contact);
}