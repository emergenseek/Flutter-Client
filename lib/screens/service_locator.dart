import 'dart:async'; // For Completer
import 'package:flutter/material.dart';
import 'package:EmergenSeek/screens/nav_menu.dart';
import 'package:EmergenSeek/screens/sos_quick_button.dart';
import 'package:EmergenSeek/screens/settings.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ServiceLocatorPage extends StatefulWidget {
  @override
  ServiceLocatorPageState createState() => ServiceLocatorPageState();
}

class ServiceLocatorPageState extends State<ServiceLocatorPage> {
  // GoogleMapController for onMapCreated
  GoogleMapController mapController;
  Completer<GoogleMapController> _controller = Completer();
  
  // ?options current location
  bool mapToggle = false;
  var currentLocation;
  // getCurrentLocation set var currentLocation
  @override
  void initState() {
    super.initState();
    Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((currLocation) {
      setState(() {
        this.currentLocation = currLocation;
        this.mapToggle = true;
      });
    });
  }

  // The screen itself with appbar, googleMap, and floating SOS
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
          // Stack over the full-screen
          children: <Widget>[
            _googleMap(),
            _buildContainer(),
            //_makeMaker(),
          ],
        ),
        floatingActionButton: QuickSOS());
  }

  // The Google Map itself, using var currentlocation
  Widget _googleMap() {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: mapToggle
            ? GoogleMap(
                mapType: MapType.normal,
                myLocationEnabled: true,
                compassEnabled: true,
                initialCameraPosition: CameraPosition(
                    target: LatLng(
                        currentLocation.latitude, currentLocation.longitude),
                    zoom: 13.5),
                // Define Google Map Controller with controller
                onMapCreated: (mapController) {
                  _controller.complete(mapController);
                })
            : Center(
                // Alternative option, if searching or cant find currentLocation
                child: Text(
                'Loading.. Please wait..',
                style: TextStyle(fontSize: 20.0),
              )));
  }

  // Marker pharmacyMarker = Marker(
  //   markerId: MarkerId('pharmacy'),
  //   position: LatLng(33.5897, -101.8560),
  //   infoWindow: InfoWindow(title: 'Pharmacy'),
  //   icon: BitmapDescriptor.defaultMarkerWithHue(
  //     BitmapDescriptor.hueBlue,
  //   ),
  // );

  // ?options store-hour
  bool open = true;
  // box - details
  String name = 'name';
  String icon = 'icon';
  double lat;
  double lng;

  // The bottom full-boxes with ALIGN. and LISTVIEW, fitted-boxes
  Widget _buildContainer() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 20.0),
          height: 150.0,
          child: mapToggle
              ? ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    SizedBox(
                      width: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: resultBox(icon, lat, lng),
                    ),
                  ],
                )
              : Center(
                  // Alternative option, if searching or cant find currentLocation
                  // NULL
                  )),
    );
  }

  // Navigating MARKER long/lat to relocate with BOXES && vs
  Future<void> goToLocation(double lat, double lng) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, lng),
      zoom: 15,
      tilt: 50.0,
      bearing: 45.0,
    )));
  }

  // _searching() return 'name' 'open'
  _searching(String name, bool open) {

  }

  Widget myDetailsContainer(String name, bool open) {
    // Searching return 'name' and 'open' hours
    // var searching = new _searching(name, open);
    this.name = name; // searching.
    this.open = open;
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                child: Text(
              name,
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
                      // option, if searching or cant find currentLocation
                      child: open
                          ? Text('open',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 18.0))
                          : Text('closed',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 18.0)))
                ]),
          )
        ]);
  }

  // _location() return 'icon' 'location'
  _location(String icon, double lat, double lng) {

  }

  Widget resultBox(String icon, double lat, double lng) {
    // Searching return 'icon' and 'location'
    // var location = new _location(icon, lat, lng);
    this.icon = icon; // location.
    this.lat = lat;
    this.lng = lng;
    return GestureDetector(
      onTap: () {
        goToLocation(33.5897, -101.8560); // Testing (lat. lng)
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
                  // Image-Icon on the left, fittedBox
                  Container(
                    width: 180,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(24.0),
                      child: Image(
                        fit: BoxFit.fill,
                        image: NetworkImage(icon),
                      ),
                    ),
                  ),
                  // Details on the right with other (), fittedBox
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: myDetailsContainer(name, open),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
