import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as google;
import 'package:yosken_challenge1/src/chargespots.dart';


google.LatLng makeMyLatLng(Position position) {
  double longitude = position.longitude;
  double latitude = position.latitude;
  final myLatLng = google.LatLng(latitude, longitude);
  return myLatLng;
}

Future<SwAndNeLatLng> makeSwAndNeLatLng(google.LatLng range)async{
  final myPosition = await Geolocator.getCurrentPosition(
  );
  final myLatLng = makeMyLatLng(myPosition);
  final swLat = myLatLng.latitude - range.latitude/2;
  final swLng = myLatLng.longitude - range.longitude/2;
  final neLat = myLatLng.latitude + range.latitude/2;
  final neLng = myLatLng.longitude + range.longitude/2;
  return SwAndNeLatLng(swLat, swLng, neLat, neLng);
}
