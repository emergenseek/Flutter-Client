import 'package:flutter/material.dart';
import 'package:EmergenSeek/screens/nav_menu.dart';
import 'package:EmergenSeek/screens/sos_quick_button.dart';
import 'package:EmergenSeek/screens/settings.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:EmergenSeek/models/app_model.dart';
import 'package:contacts_service/contacts_service.dart';

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() {
    return new _ContactsPageState();
  }
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.blueGrey[400],
        drawer: NavMenu(),
        appBar: AppBar(
          title: Text("Contacts"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              tooltip: 'Refresh Contacts',
              onPressed: () {
                setState(() {
                  // Refreshes contacts list
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.settings),
              tooltip: 'Settings',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SettingsContacts()));
              },
            )
          ],
        ),
        body: new FutureBuilder(
          future: ScopedModel.of<AppModel>(context).refreshContacts(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ScopedModelDescendant<AppModel>(
                  builder: (context, child, model) => ListTileTheme(
                      textColor: Colors.white,
                      iconColor: Colors.blue[200],
                      child: ListView(
                        children: buildContactList(model.getContacts()),
                      )));
            } else {
              return Center(
                  child: Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 16.0),
                      child: CircularProgressIndicator()));
            }
          },
        ),
        floatingActionButton: QuickSOS());
  }

  // Constructs and returns list of contacts formatted as list tiles
  List<ContactListItem> buildContactList(Iterable<Contact> contacts) {
    return contacts.map((contact) => ContactListItem(contact)).toList();
  }
}

// List view representation of a contact
class ContactListItem extends ListTile {
  ContactListItem(Contact contact)
      : super(
            title: Text(contact.displayName),
            subtitle: Text(contact.phones.first.value),
            leading: CircleAvatar(child: Text(contact.displayName[0])));
}
