import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yosken_challenge1/charge_spots_list_page.dart';
import 'package:yosken_challenge1/component/cardlist.dart';
import 'package:yosken_challenge1/component/marker.dart';
import 'package:yosken_challenge1/src/chargespots.dart' as chargespots;
import 'package:riverpod/riverpod.dart';
import 'package:yosken_challenge1/google_map_page.dart';
import 'package:yosken_challenge1/component/pageview.dart';
import 'package:yosken_challenge1/component/card.dart';
import 'package:yosken_challenge1/model/fetch_my_location.dart' as my_location;

// final startFetchProvider = StateProvider((ref) => chargespots.chargerSpotsFutureProvider);

class ChargeSpotInfoPageView extends ConsumerWidget {
  const ChargeSpotInfoPageView(
      this.myIcon, this.googleMapController, this.markerController,
      {Key? key})
      : super(key: key);
  final GoogleMapController googleMapController;
  final StreamController<Set<Marker>> markerController;
  final BitmapDescriptor myIcon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PageController pageController =
        PageController(viewportFraction: 0.85);
    // final currentLatLng = ref.watch(chargespots.latLngProvider); //ボタン押したりinitstateで変わる

    final mapIcon = myIcon;
    final asyncMyLatLng = ref.watch(chargespots.rangeLatLngProvider);
    final asyncMyPosition = ref.watch(chargespots.myPositionProvider);
    final mapController = googleMapController;
    final markerCntrlr = markerController;
    final rangeProvider = ref.read(chargespots.rangeProvider);

    //final fetch = ref.watch(startFetchProvider);//currentLatLngが変わることで、chargespotsFutureProviderが変わる（Api取得開始）

    final asyncValue = ref.watch(
        chargespots.chargerSpotsFutureProvider); //api取得したら変わる、取得するまでloading

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: 60,
        ),
        Expanded(
          child: Container(
            alignment: Alignment.topCenter,

            child: SizedBox(
              width: 396,
              height: 62,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    foregroundColor: const Color.fromRGBO(86, 198, 0, 1),
                    backgroundColor: const Color.fromRGBO(243, 255, 233, 1),
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () {
                    ref.read(chargespots.countProvider.notifier).state++;

                    asyncMyPosition.when(
                        data: (value) {
                          mapController.animateCamera(
                              CameraUpdate.newCameraPosition(CameraPosition(
                                  target: LatLng(
                                      value.swLat + rangeProvider.latitude / 2,
                                      value.swLng + rangeProvider.longitude / 2),
                                  zoom: 14)));

                          ref
                              .read(chargespots.rangeLatLngProvider.notifier)
                              .state = value;
                        },
                        error: (error, stack) => print('Error: $error'),
                        loading: () => print('loading'));
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 27),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('現在地でポートを検索'),
                        const Icon(Icons.search_rounded)
                      ],
                    ),
                  )),
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.fromLTRB(0, 0, 16, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 45,
                width: 140,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(58, 58, 58, 1),
                    foregroundColor: Colors.white,
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () {
                    //ここにcurrentPosition入れる
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        //trueにしないと、Containerのheightが反映されない
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(15)),
                        ),
                        builder: (BuildContext context) =>
                            ChargeSpotInfoPage(pageController, mapController));
                  },
                  child: Row(
                    children: [
                      Icon(Icons.list),
                      Text(
                        'リストを表示',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              ElevatedButton(
                onPressed: () {
                  ref.read(chargespots.countProvider.notifier).state++;

                  asyncMyPosition.when(
                      data: (value) {
                        mapController.animateCamera(
                            CameraUpdate.newCameraPosition(CameraPosition(
                                target: LatLng(
                                    value.swLat + rangeProvider.latitude / 2,
                                    value.swLng + rangeProvider.longitude / 2),
                                zoom: 14)));
                      },
                      error: (error, stack) => print('Error: $error'),
                      loading: () => print('loading'));
                },
                child: const Icon(
                  Icons.my_location_sharp,
                  color: Colors.white,
                ),
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(62, 62),
                    backgroundColor: Color.fromRGBO(58, 58, 58, 1),
                    shape: CircleBorder()),
              ),
            ],
          ),
        ),
        asyncValue.when(
          data: (value) {
            // MapPageState().updateMarkers(value);

            final _markers = makeMarker(value, mapIcon);
            markerCntrlr.sink.add(_markers);
            return Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: SizedBox(
                height: 272,
                child: PageView(
                  controller: pageController,
                  onPageChanged: (int index) {
                    final selectSpot = value.charger_spots!.elementAt(index);
                    mapController.animateCamera(CameraUpdate.newCameraPosition(
                        CameraPosition(
                            target: LatLng(
                                selectSpot.latitude!, selectSpot.longitude!),
                            zoom: 14)));
                  },
                  children: makeCardList(value),
                ),
              ),
            );
          },
          error: (error, stack) => Text('Error: $error'),
          loading: () => Padding(
            padding: const EdgeInsets.symmetric(vertical: 116),
            child: SizedBox(
                height: 80,
                width: 80,
                child: const CircularProgressIndicator()),
          ),
        ),
      ],
    );
  }
}

// class ChargeSpotInfoPageView extends ConsumerWidget {
//   const ChargeSpotInfoPageView({Key? key, Position? currentPosition})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final PageController pageController = PageController(
//         viewportFraction: 0.85);
//     print('beforeWatch');
//     final asyncValue =
//     ref.watch(chargespots.chargerSpotsFutureProvider(swAndNeLatLng));
//
//     return asyncValue.when(
//       data: (value) {
//         print('hello');
//         return Container(
//           height: 430,
//           child: PageView(
//             controller: pageController,
//             children: makeCardList(value),
//           ),
//         );
//       },
//       error: (error, stack) => Text('Error: $error'),
//       loading: () =>
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 175),
//             child: SizedBox(height: 80,
//                 width: 80,
//                 child: const CircularProgressIndicator()),
//           ),
//     );
//   }
// }
