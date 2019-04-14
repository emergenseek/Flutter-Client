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
  GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  // Heading to GoogleMapAndroid App
  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // The Google Map and Marker
  Widget _googleMap() {
    Set<Marker> markers = Set<Marker>();
    callLocator(this.data);
    for (var i = 0; i < this.data.length; i++) {
      markers.add(Marker(
        markerId: MarkerId(this.data[i].name),
        position:
            LatLng(this.data[i].location['lat'], this.data[i].location['lng']),
        onTap: () {
          mapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                bearing: 40.0,
                target: LatLng(
                    this.data[i].location['lat'], this.data[i].location['lng']),
                tilt: 52.0,
                zoom: 16.5,
              ),
            ),
          );
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
    } // Finished searching for markers

    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GoogleMap(
          mapType: MapType.normal,
          myLocationEnabled: true,
          compassEnabled: true,
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
              target:
                  LatLng(currentLocation.latitude, currentLocation.longitude),
              zoom: 14.5),
          markers: markers,
        ));
  } // End of map and marker ()

  var future1 = new Future.delayed(new Duration(seconds: 6), () => 1);
  //var future2 =
    //  new Future.delayed(new Duration(seconds: 2), () => throw 'error');

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
        body: new FutureBuilder(
          future: Future.wait([future1], eagerError: true,
              cleanUp: (value) {
            print('processed $value');
          }).then(print).catchError(print),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (locationToggle) {
              return Stack(
                  // Stack over the full-screen
                  children: <Widget>[_googleMap()]);
            } else {
              return Center(
                  // Alternative option, if searching or cant find currentLocation
                  child: Text(
                'Loading.. Please wait..',
                style: TextStyle(fontSize: 20.0),
              ));
            }
          },
        ),
        floatingActionButton: QuickSOS());
  } // End Of build()
  
} // End of class ServiceLocatorPageState
