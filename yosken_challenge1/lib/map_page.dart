import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yosken_challenge1/spot_info_page_view.dart';
import 'package:yosken_challenge1/constant/importer_constant.dart';
import 'package:yosken_challenge1/constant/others.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  Position? currentPosition; //現在位置
  Widget _asyncWidget = loadingIndicatorForPageView;
  Set<Marker> _markers = {};
  late BitmapDescriptor myIcon = BitmapDescriptor.defaultMarker;
  final Completer<GoogleMapController> _controller = Completer();
  late StreamSubscription<Position> positionStream; //現在地をlistenし続ける関数
  final markerController = StreamController<Set<Marker>>();
  final CameraPosition _tokyoStation = firstCameraPosition; //初期位置
  final LocationSettings locationSettings = locationSettingsForMap;

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
          padding: mapCenterPosition,
          initialCameraPosition: _tokyoStation,
          myLocationButtonEnabled: false,
          //現在位置のボタン
          myLocationEnabled: true,
          //現在位置をマップ上に表示
          markers: _markers,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
            asyncSpotInfoPageView();
          },
        ),
        _asyncWidget,
      ],
    );
  }

  ///model_mapControllerがcreateされるまでawait
  Future<void> asyncSpotInfoPageView() async {
    final GoogleMapController mapController = await _controller.future;
    final myIcon = BitmapDescriptor.fromBytes(
        await getBytesFromAsset(markerImagePath, markerSize));
    setState(() {
      _asyncWidget = SpotInfoPageView(
        myIcon,
        mapController,
        markerController,
      );
    });
  }
  ///model_pngをUint8List型に変換
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}
