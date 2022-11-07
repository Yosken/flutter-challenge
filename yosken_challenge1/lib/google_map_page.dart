import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yosken_challenge1/charge_spots_list_page.dart';
import 'package:yosken_challenge1/charge_spots_list_page2.dart';
import 'package:yosken_challenge1/component/marker_custom.dart';
import 'package:yosken_challenge1/component/pageview.dart';
import 'package:yosken_challenge1/component/show_modal_bottom_sheet.dart';
import 'package:yosken_challenge1/model/fetch_my_location.dart';
import 'package:yosken_challenge1/component/marker.dart';
import 'package:yosken_challenge1/src/chargespots.dart' as chargespots;

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  Position? currentPosition; //何でか知らんが、google mapの現在地はこれを取得
  Widget _asyncWidget = const CircularProgressIndicator();
  Set<Marker> _markers = {};

  // final GlobalKey globalKey = GlobalKey();
  late BitmapDescriptor myIcon = BitmapDescriptor.defaultMarker;

  // late GoogleMapController? _controller;
  Completer<GoogleMapController> _controller = Completer();
  late StreamSubscription<Position> positionStream; //現在地をlistenし続ける関数

  final markerController = StreamController<Set<Marker>>();

  //初期位置
  final CameraPosition _tokyoStation = const CameraPosition(
    target: LatLng(35.681789, 139.766948),
    zoom: 14,
  );

  final int _i = 0;

  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high, //正確性:highはAndroid(0-100m),iOS(10m)
    distanceFilter: 100,
  );

  @override
  void initState() {
    super.initState();

    //位置情報が許可されていない時に許可をリクエストする
    Future(() async {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        await Geolocator.requestPermission();
      }
    });

    //現在位置を更新し続ける
    positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) {
      currentPosition = position;
      print('change position');
    });



    //marker更新
    markerController.stream.listen((event) {
      setState(() {
        _markers = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        GoogleMap(
          mapType: MapType.normal,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 240),
          initialCameraPosition: _tokyoStation,
          myLocationButtonEnabled: false,
          //現在位置のボタン
          myLocationEnabled: true,
          //現在位置をマップ上に表示
          markers: _markers,
          onMapCreated: (GoogleMapController controller) {
            // _controller = controller;
            // setState(() {
            //   _widget = ChargeSpotInfoPageView(_controller!);
            // });
            _controller.complete(controller);
            asyncChargeSpotInfoPageView();
          },
        ),
        _asyncWidget,
      ],
    );
  }

  void moveCamera(GoogleMapController? controller, LatLng latLng) {
    controller?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: 19)));
  }

  Future<void> asyncChargeSpotInfoPageView() async {
    final GoogleMapController mapController = await _controller.future;
    final myIcon = BitmapDescriptor.fromBytes(await getBytesFromAsset('assets/marker.png', 150));
    setState(() {
      _asyncWidget = ChargeSpotInfoPageView(
        myIcon,
        mapController,
        markerController,
      );
    });
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }


// void updateMarkers(chargespots.ChargerSpots chargerSpots) {
//   final currentMarkers = makeMarker(chargerSpots);
//   setState(() {
//     _markers = currentMarkers;
//   });
// }

//
// Future<void> moveToTheLocation(LatLng latLng)async{
//   final GoogleMapController mapController = await _controller.future;
//   mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: latLng,zoom: 19)));
// }
}
