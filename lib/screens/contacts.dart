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
                        children: buildContactList(model.getContacts(), context),
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
  List<ContactListItem> buildContactList(Iterable<Contact> contacts, BuildContext context) {
    return contacts.map((contact) => ContactListItem(contact, context)).toList();
  }
}

// List view representation of a contact
class ContactListItem extends ListTile {
  ContactListItem(Contact contact, BuildContext context)
      : super(
            title: Text(contact.displayName),
            subtitle: Text(contact.phones.first.value),
            leading: CircleAvatar(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue[200],
                child: Text(contact.displayName[0])),
            onTap: () {showTiers(context);}
  );
}

// Dialog box for adding contacts to an alert tier
void showTiers(BuildContext context) {
  showDialog(
    context: context,
      builder: (BuildContext context) {
        return ScopedModelDescendant<AppModel>(
            builder: (context, child, model) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              contentPadding: EdgeInsets.all(17.0),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Text(
                    "Add this contact to an alert tier",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25.0),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 12.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new FlatButton(
                          onPressed: () {
                            //TODO: Add to tier
                            Navigator.of(context).pop();
                          },
                          child: new Text(
                            "Tier 1",
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.red),
                          )),
                      new FlatButton(
                          onPressed: () {
                            //TODO: Add to tier
                            Navigator.of(context).pop();
                          },
                          child: new Text(
                            "Tier 2",
                            style: TextStyle(
                                fontSize: 18.0, color: Colors.blueAccent),
                          )),
                      new FlatButton(
                          onPressed: () {
                            //TODO: Add to tier
                            Navigator.of(context).pop();
                          },
                          child: new Text(
                            "Tier 3",
                            style: TextStyle(
                                fontSize: 18.0, color: Colors.tealAccent[400]),
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: new Text(
                            "Cancel",
                            style: TextStyle(
                                fontSize: 16.0, color: Colors.black),
                          )),
                    ],
                  )
                ],
              ),
            ));
      });
}
