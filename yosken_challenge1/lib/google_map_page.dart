import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yosken_challenge1/charge_spots_list_page.dart';
import 'package:yosken_challenge1/charge_spots_list_page2.dart';

import 'package:yosken_challenge1/component/pageview.dart';
import 'package:yosken_challenge1/component/show_modal_bottom_sheet.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  Position? currentPosition;
  late GoogleMapController _controller;
  late StreamSubscription<Position> positionStream;

  //初期位置
  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(43.0686606, 141.3485613),
    zoom: 14,
  );

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
      print(position == null
          ? 'Unknown'
          : '${position.latitude.toString()}, ${position.longitude.toString()}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        GoogleMap(
          mapType: MapType.normal,
          padding: const EdgeInsets.fromLTRB(0, 0, 12, 492),
          initialCameraPosition: _kGooglePlex,
          myLocationButtonEnabled: true,
          //現在位置のボタン
          myLocationEnabled: true,
          //現在位置をマップ上に表示
          onMapCreated: (GoogleMapController controller) {
            _controller = controller;
          },
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.fromLTRB(0, 0, 12, 12),
              child: SizedBox(
                height: 48,
                width: 120,
                child: ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        //trueにしないと、Containerのheightが反映されない
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(15)),
                        ),
                        builder: (BuildContext context) => Container(
                          height: double.infinity,
                          child:  ChargeSpotInfoPage(),
                        )
                    );
                  },
                  child: Text('リストを表示'),
                ),
              ),
            ),
            const ChargeSpotInfoPageView(),
          ],
        ),
      ],
    );
  }
}
