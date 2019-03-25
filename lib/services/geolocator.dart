import 'package:geolocator/geolocator.dart';

Future<Map> getCurrentLocation() async {
  Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  double lat = position.latitude;
  double long = position.longitude;
  Map<String, double> coordinates = {
    "latitude": lat,
    "longitude": long,
  };
  return coordinates;
}

Future<Position> getLastKnownLocation() async {
  Position position = await Geolocator().getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
  return position;
}