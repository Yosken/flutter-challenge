import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'importer_constant.dart';


///google_map_page
const CameraPosition firstCameraPosition = CameraPosition(target: LatLng(firstLat, firstLng),zoom: defaultZoom);
//正確性:highはAndroid(0-100m),iOS(10m)
const LocationSettings locationSettingsForMap = LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 100);
//検索範囲
const LatLng rangeLatLng = LatLng(0.1,0.1);
//初期位置
const LatLng firstLatLng = LatLng(firstLat,firstLng);

//検索ボタンのUI
dynamic searchButtonStyle = ElevatedButton.styleFrom(
  padding: EdgeInsets.zero,
  foregroundColor: searchButtonForeColor,
  backgroundColor: searchButtonBackColor,
  shape: const StadiumBorder(),
);

//リスト表示ボタンのUI
dynamic showListButtonStyle = ElevatedButton.styleFrom(
  foregroundColor: Colors.white,
  backgroundColor: myLocationBtnBackColor,
  shape: const StadiumBorder(),
);

dynamic myLocationButtonStyle = ElevatedButton.styleFrom(
    fixedSize:
    const Size(myLocationButtonSize, myLocationButtonSize),
    backgroundColor: myLocationBtnBackColor,
    shape: const CircleBorder()
);

final RoundedRectangleBorder cardShape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(12));