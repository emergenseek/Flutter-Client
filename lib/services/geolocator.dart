import 'package:geolocator/geolocator.dart';

Future<List> getCurrentLocation() async {
  Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  double lat = position.latitude;
  double long = position.longitude;
  List<double> coordinates = [lat, long];
  /*
  Map<String, double> coordinates = {
    "latitude": lat,
    "longitude": long,
  };
  */
  return coordinates;
}

Future<Position> getLastKnownLocation() async {
  Position position = await Geolocator().getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
  return position;
}

Future<List> placemarkFromCoordinates(double lat, double long) async {
  List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(lat, long);
  return placemark;
}