import 'dart:async'; // For Completer
import 'package:flutter/material.dart';
import 'package:EmergenSeek/screens/nav_menu.dart';
import 'package:EmergenSeek/screens/sos_quick_button.dart';
import 'package:EmergenSeek/screens/settings.dart';
import 'package:EmergenSeek/services/api.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceLocatorPage extends StatefulWidget {
  @override
  ServiceLocatorPageState createState() => ServiceLocatorPageState();
}

class ServiceLocatorPageState extends State<ServiceLocatorPage> {
  // ?options for body: only run when there is currentLocation located
  bool locationToggle = false;
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
        this.locationToggle = true;
      });
    });
  }

  // Accesing APIs with List<Detail>
  List<Detail> data = new List<Detail>();
  // GoogleMapController for onMapCreated
  GoogleMapController controller;
  Completer<GoogleMapController> _controller = Completer();

  // Navigating long/lat to relocate with selected marker
  Future<void> goToLocation() async {
    final GoogleMapController controller = await _controller.future;
    callLocator(this.data);
    for (var i = 0; i < this.data.length; i++) {
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target:
            LatLng(this.data[i].location['lat'], this.data[i].location['lng']),
        zoom: 16.5,
        tilt: 52.0,
        bearing: 40.0,
      )));
    }
  } // End of goToLocation effects

  // Heading to GoogleMapAndroid App
  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // The Google Map and Marker, using var currentlocation
  Widget _googleMap() {
    Set<Marker> markers = Set<Marker>();
    callLocator(this.data);
    for (var i = 0; i < this.data.length; i++) {
      markers.add(Marker(
        markerId: MarkerId(this.data[i].name),
        position:
            LatLng(this.data[i].location['lat'], this.data[i].location['lng']),
        onTap: () {
          goToLocation();
        },
        infoWindow: InfoWindow(
            onTap: () => _launchURL(
                "google.navigation:q=${this.data[i].location['lat']},${this.data[i].location['lng']}"
                // For Google Maps in a browser
                //"http://maps.google.com/?q=${this.data[i].location['lat']},${this.data[i].location['lng']}"
                ),
            title: this.data[i].name,
            snippet: this.data[i].open ? 'open' : 'closed'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ));
    } // End of marker-search

    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GoogleMap(
          markers: markers,
          mapType: MapType.normal,
          myLocationEnabled: true,
          compassEnabled: true,
          initialCameraPosition: CameraPosition(
              target:
                  LatLng(currentLocation.latitude, currentLocation.longitude),
              zoom: 14),
          // Define Google Map Controller for goToController()
          onMapCreated: (controller) {
            _controller.complete(controller);
          },
        ));
  } // End of map and marker ()

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
        body: locationToggle
            ? Stack(
                // Stack over the full-screen
                children: <Widget>[_googleMap()])
            : Center(
                // Alternative option, if searching or cant find currentLocation
                child: Text(
                'Loading.. Please wait..',
                style: TextStyle(fontSize: 20.0),
              )),
        floatingActionButton: QuickSOS());
  } // End Of build()
} // End of class ServiceLocatorPageState
