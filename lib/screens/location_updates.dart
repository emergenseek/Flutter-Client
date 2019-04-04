import 'package:flutter/material.dart';
import 'nav_menu.dart';
import 'sos.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:EmergenSeek/models/app_model.dart';

/*
class LocationUpdatesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.blueGrey,
      drawer: NavMenu(),
      appBar: AppBar(
        title: Text("Location Updates"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Ink(
              decoration : ShapeDecoration(
                color : Colors.white70,
                shape: CircleBorder(),
              ),
              child: IconButton(
              icon: Icon(Icons.person_outline),
                  iconSize: 250.0,
              color: Colors.lightBlueAccent,
              splashColor: Colors.blue,
              highlightColor: Colors.blue,
              onPressed: () {
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SOSPage())
                );
              }
            ),
          )

          ]
      )
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'S.O.S.',
        child: Icon(Icons.error_outline, size: 35.0),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SOSPage()));
        },
      ),

    );
  }
}
*/

class LocationUpdatesPage extends StatefulWidget{
  @override
  LUpdatesSettingsState createState(){
    return new LUpdatesSettingsState();
  }
}

class LUpdatesSettingsState extends State<LocationUpdatesPage>{
  @override
  Widget build(BuildContext context){
   return ScopedModelDescendant<AppModel>(
     builder: (context, child, model) => Scaffold(
       backgroundColor: Theme.of(context).accentColor,
       appBar: AppBar(
         backgroundColor: Theme.of(context).primaryColor,
         title: Text("Location Updates")
       ),
       //drawer: NavMenu(),
       body: ListTileTheme(
         textColor: Colors.white,
         iconColor: Colors.blue[200],
         child: ListView(
           children: <Widget>[
             CheckboxListTile(
               title: Text("Primary Contacts"),
               subtitle: Text("Enable to include primary contacts in location update"),
               activeColor: Colors.blue[200],
               value: model.getPrimaryContacts(),
               onChanged: (value){
                 model.togglePrimaryContacts();
               },
             ),
             CheckboxListTile(
               title: Text("Secondary Contacts"),
               subtitle: Text("Enable to include secondary contacts in location update"),
               activeColor: Colors.blue[200],
               value: model.getSecondaryContacts(),
               onChanged: (value){
                 model.toggleSecondaryContacts();
               },
             ),
             CheckboxListTile(
               title: Text("Tertiary Contacts"),
               subtitle: Text("Enable to include tertiary contacts in location update"),
               activeColor: Colors.blue[200],
               value: model.getTertiaryContacts(),
               onChanged: (value){
                 model.toggleTertiaryContacts();
               },
             ),
             Ink(
               decoration : ShapeDecoration(
                 color : Colors.white70,
                 shape: CircleBorder(),
               ),
               child: IconButton(
                   icon: Icon(Icons.room),
                   iconSize: 250.0,
                   color: Colors.lightBlueAccent,
                   splashColor: Colors.blue,
                   highlightColor: Colors.blue,
                   onPressed: () {
                     Navigator.push(
                         context, MaterialPageRoute(builder: (context) => SOSPage())
                     );
                   }
               ),
             ),
           ],
         )
       ),
       floatingActionButton: FloatingActionButton(
       tooltip: 'S.O.S.',
       child: Icon(Icons.error_outline, size: 35.0),
       onPressed: () {
         Navigator.push(
             context, MaterialPageRoute(builder: (context) => SOSPage()));
       },
     ),

     )

   );
  } //Widget
} //LUpdatesSettings


/*
class LUpdatesButtonState extends StatefulWidget {
  @override
  LUpdatesButton createState() {
    return new LUpdatesButton();
  }
}
class LUpdatesButton extends State<LUpdatesButtonState> {
  @override
  Widget build(BuildContext context) {
    body: Center(
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center
      children: <Widget>[
        RawMaterialButton(

        )
    )
    )
      ]
  }
}
*/

