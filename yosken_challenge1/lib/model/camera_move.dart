import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yosken_challenge1/constant/importer_constant.dart';
import 'package:yosken_challenge1/src/chargespots.dart';

void moveCamera(GoogleMapController googleMapController, SwAndNeLatLng swAndNeLatLng, dynamic stateProvider) {
  googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(
              swAndNeLatLng.swLat + stateProvider.latitude / 2,
              swAndNeLatLng.swLng +
                  stateProvider.longitude / 2),
          zoom: defaultZoom)));
}

void moveCameraForPageChanged(GoogleMapController googleMapController, ChargerSpot chargerSpot) {
  googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(
              chargerSpot.latitude!, chargerSpot.longitude!),
          zoom: defaultZoom)));
}


