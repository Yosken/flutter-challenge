import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yosken_challenge1/component/pageview.dart';
import 'package:yosken_challenge1/src/chargespots.dart';

Set<Marker> makeMarker(ChargerSpots chargerSpots) {
  final chargerSpot = chargerSpots.charger_spots!;
  Set<Marker> markers = chargerSpot
      .map((e) => Marker(
            markerId: MarkerId(e.uuid!),
            position: LatLng(e.latitude!, e.longitude!),
            icon: BitmapDescriptor.defaultMarker,
          ))
      .toSet();

  return markers;
}

