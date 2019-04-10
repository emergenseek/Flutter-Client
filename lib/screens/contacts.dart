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
        endDrawer: FilterMenu(),
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
              icon: Icon(Icons.filter_list),
              tooltip: 'Refresh Contacts',
              //TODO: Open filter drawer onPressed
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
                        children:
                            buildContactList(model.getContacts(), context),
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
  List<ContactListItem> buildContactList(
      Iterable<Contact> contacts, BuildContext context) {
    return contacts
        .map((contact) => ContactListItem(contact, context))
        .toList();
  }
}

// List view representation of a contact
class ContactListItem extends ListTile {
  ContactListItem(Contact contact, BuildContext context)
      : super(
            title: Text(contact.displayName),
            subtitle: Text(contact.phones.first.value),
            //TODO: Add tier display trailing:
            leading: CircleAvatar(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue[200],
                child: Text(contact.displayName[0])),
            onTap: () {
              showTiers(context, contact);
            });
}

// Dialog box for adding contacts to an alert tier
void showTiers(BuildContext context, Contact contact) {
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
                                List<String> displayName = contact.displayName.split(" ");
                                model.addNewContact(displayName[0], displayName[1], contact.phones.first.value, 1);
                                Navigator.of(context).pop();
                              },
                              child: new Text(
                                "Tier 1",
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.red),
                              )),
                          new FlatButton(
                              onPressed: () {
                                List<String> displayName = contact.displayName.split(" ");
                                model.addNewContact(displayName[0], displayName[1], contact.phones.first.value, 2);
                                Navigator.of(context).pop();
                              },
                              child: new Text(
                                "Tier 2",
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.blueAccent),
                              )),
                          new FlatButton(
                              onPressed: () {
                                List<String> displayName = contact.displayName.split(" ");
                                model.addNewContact(displayName[0], displayName[1], contact.phones.first.value, 3);
                                Navigator.of(context).pop();
                              },
                              child: new Text(
                                "Tier 3",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.tealAccent[400]),
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

class FilterMenu extends StatefulWidget {
  @override
  FilterMenuState createState() {
    return new FilterMenuState();
  }
}

class FilterMenuState extends State<FilterMenu> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
        builder: (context, child, model) => Drawer(
            child: Container(
                color: Theme.of(context).primaryColor,
                child: ListTileTheme(
                    iconColor: Colors.white,
                    textColor: Colors.white,
                    child: ListView(
                      children: <Widget>[
                        Container(
                          height: 50.0,
                          child: DrawerHeader(
                              child: Text("Filter Contacts",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17.0))),
                        ),
                        CheckboxListTile(
                          title: Text("Unregistered"),
                          activeColor: Colors.blue[200],
                          value: model.getShowUnregistered(),
                          onChanged: (value) {
                            model.toggleUnregistered();
                            setState(() {});
                          },
                        ),
                        CheckboxListTile(
                          title: Text("Tier 1"),
                          activeColor: Colors.blue[200],
                          value: model.getShowTier1(),
                          onChanged: (value) {
                            model.toggleTier1();
                            setState(() {});
                          },
                        ),
                        CheckboxListTile(
                          title: Text("Tier 2"),
                          activeColor: Colors.blue[200],
                          value: model.getShowTier2(),
                          onChanged: (value) {
                            model.toggleTier2();
                            setState(() {});
                          },
                        ),
                        CheckboxListTile(
                          title: Text("Tier 3"),
                          activeColor: Colors.blue[200],
                          value: model.getShowTier3(),
                          onChanged: (value) {
                            model.toggleTier3();
                            setState(() {});
                          },
                        ),
                      ],
                    )))));
  }
}
