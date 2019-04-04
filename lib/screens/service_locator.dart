import 'dart:async'; // For Completer
import 'package:flutter/material.dart';
import 'package:EmergenSeek/screens/nav_menu.dart';
import 'package:EmergenSeek/screens/sos_quick_button.dart';
import 'package:EmergenSeek/screens/settings.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ServiceLocatorPage extends StatefulWidget {
  @override
  _ServiceLocatorPageState createState() {
    return new _ServiceLocatorPageState();
  }
}

// The screen itself, contains an app bar, the map, and the SOS button
class _ServiceLocatorPageState extends State<ServiceLocatorPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.blueGrey[400],
        drawer: NavMenu(),
        appBar: AppBar(
          title: Text("Service Locator"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              tooltip: 'Settings',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SettingsServiceLocator()));
              },
            )
          ],
        ),
        body: Stack(
          children: <Widget>[
            googleMap(context),
            buildContainer(),
          ],
        ),
        floatingActionButton: QuickSOS());
  }
}

// Google Map Controller for zoom_in function
Completer<GoogleMapController> _controller = Completer();
Widget googleMap(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition:
              // TO DO: Get_User_LatLng and place in 'target'
              CameraPosition(target: LatLng(33.5779, -101.8552), zoom: 12),
              //Define Google Map Controller with controller
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          /*markers: {
            // TO DO: SELECTED_MarkerID such as pharmacy, hospital
            pharmacyMarker, hospitalMarker
          },*/
        ));
  }

// Navigating MARKER long/lat to relocate with BOXES && vs
  Future<void> goToLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 15,
      tilt: 50.0,
      bearing: 45.0,
    )));
  }

Marker pharmacyMarker = Marker(
  markerId: MarkerId('pharmacy'),
  // TO DO: Get_Searched_LatLng
  position: LatLng(33.5897, -101.8560),
  // TO DO: Get_SELECTED_Searched_Place
  infoWindow: InfoWindow(title: 'Pharmacy'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueBlue,
  ),
);

// TO DO: Loop for more Get_Searched_LatLng
Marker hospitalMarker = Marker(
  markerId: MarkerId('hospital'),
  // TO DO: Get_Searched_LatLng
  position: LatLng(33.5885, -101.8931),
  // TO DO: Get_SELECTED_Searched_Place
  infoWindow: InfoWindow(title: 'Hospital'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueBlue,
  ),
);

// TO DO: API details
Widget buildContainer() {
  return Align(
    alignment: Alignment.bottomLeft,
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      height: 150.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          SizedBox(
            width: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            // TO DO: API details
            child: boxes(
                "https://i.ibb.co/z8CgfZy/453947-walgreens-photo.jpg",
                33.5897, -101.8560,
                "Pharmacy"),
          ),
          SizedBox(
            width: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            // TO DO: API details
            child: boxes(
                "https://i.ibb.co/zmW2gnf/2017-11-08large-data-breach.jpg",
                33.5885, -101.8931,
                "Hospital"),
          )
        ],
      ),
    ),
  );
}

Widget boxes(String _image, double lat, double long, String locationName) {
  return GestureDetector(
    onTap: () {
      goToLocation(lat, long);
    },
    child: Container(
      child: new FittedBox(
        child: Material(
            color: Colors.white,
            elevation: 14.0,
            borderRadius: BorderRadius.circular(24.0),
            shadowColor: Color(0x802196F3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 180,
                  height: 200,
                  child: ClipRRect(
                    borderRadius: new BorderRadius.circular(24.0),
                    child: Image(
                      fit: BoxFit.fill,
                      image: NetworkImage(_image),
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: myDetailsContainer(locationName),
                  ),
                )
              ],
            )),
      ),
    ),
  );
}

// TO DO: API details
Widget myDetailsContainer(String locationName) {
  return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              child: Text(
            locationName,
            style: TextStyle(
                color: Color(0xff6200ee),
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          )),
        ),
        SizedBox(height: 5.0),
        Container(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  child: Text("Details: ... ",
                      style: TextStyle(color: Colors.black54, fontSize: 18.0)),
                )
              ]),
        )
      ]);
}
