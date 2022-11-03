// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'src/chargespots.dart' as chargespots;
// import 'package:riverpod/riverpod.dart';
// import 'package:yosken_challenge1/component/card.dart';
//
// void main() {
//   runApp(const ProviderScope(child: MyApp()));
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     print('build');
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const ChargeSpotInfoPage(),
//     );
//   }
// }
//
// final chargespots.SwAndNeLatLng swAndNeLatLng = chargespots.SwAndNeLatLng(
//     34.683331703634124,
//     139.7657155055581,
//     35.686849507072736,
//     139.77340835691592);
//
// class ChargeSpotInfoPage extends ConsumerWidget {
//   const ChargeSpotInfoPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//
//
//     print('beforeWatch');
//     final asyncValue =
//         ref.watch(chargespots.chargerSpotsFutureProvider(swAndNeLatLng));
//
//     return Scaffold(
//       body: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 32),
//         child: asyncValue.when(data: (value){
//           print('hello');
//           return ListView.builder(
//             itemCount: value.charger_spots!.length,
//             itemBuilder: (BuildContext context, int index) {
//               final spotData = value.charger_spots![index];
//               return makeCard(spotData);
//             },
//           );
//         },
//           error: (error, stack) => Text('Error: $error'),
//           loading: () => const CircularProgressIndicator(),),
//       ),
//     );
//   }
// }
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
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
      if(permission == LocationPermission.denied){
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
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _kGooglePlex,
      myLocationEnabled: true,//現在位置をマップ上に表示
      onMapCreated: (GoogleMapController controller) {
        _controller = controller;
      },
    );
  }
}
