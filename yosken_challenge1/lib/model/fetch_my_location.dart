import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as google;
import 'package:yosken_challenge1/src/chargespots.dart';

Future<Position> getMyPosition() async {
  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high
  );
  return position;
}

google.LatLng makeMyLatLng(Position position) {
  double longitude = position.longitude;
  double latitude = position.latitude;
  final myLatLng = google.LatLng(latitude, longitude);
  return myLatLng;
}

// SwAndNeLatLng getSwAndNeLatLng(Position position, google.LatLng range){
//   final myLatLng = makeMyLatLng(position);
//   final swLat = myLatLng.latitude - range.latitude/2;
//   final swLng = myLatLng.longitude - range.longitude/2;
//   final neLat = myLatLng.latitude + range.latitude/2;
//   final neLng = myLatLng.longitude + range.longitude/2;
//   print(swLat);
//   return SwAndNeLatLng(swLat, swLng, neLat, neLng);
// }

Future<SwAndNeLatLng> getSwAndNeLatLng(google.LatLng range)async{
  final myPosition = await Geolocator.getCurrentPosition(
  );
  final myLatLng = makeMyLatLng(myPosition);
  final swLat = myLatLng.latitude - range.latitude/2;
  final swLng = myLatLng.longitude - range.longitude/2;
  final neLat = myLatLng.latitude + range.latitude/2;
  final neLng = myLatLng.longitude + range.longitude/2;
  print(swLat);
  return SwAndNeLatLng(swLat, swLng, neLat, neLng);
}

// final myLatLngProvider = FutureProvider((ref) => getMyLatLng());


