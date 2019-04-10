import 'package:geolocator/geolocator.dart';

Future<List> pollCurrentLocation() async {
  Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  double lat = position.latitude;
  double long = position.longitude;
  List<double> coordinates = [lat, long];

  return coordinates;
}

Future<Position> pollLastKnownLocation() async {
  Position position = await Geolocator().getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
  return position;
}

Future<List> placemarkFromCoordinates(double lat, double long) async {
  List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(lat, long);
  return placemark;
}