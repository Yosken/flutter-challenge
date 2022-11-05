import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yosken_challenge1/charge_spots_list_page.dart';
import 'package:yosken_challenge1/component/cardlist.dart';
import 'package:yosken_challenge1/src/chargespots.dart' as chargespots;
import 'package:riverpod/riverpod.dart';
import 'package:yosken_challenge1/google_map_page.dart';
import 'package:yosken_challenge1/component/pageview.dart';
import 'package:yosken_challenge1/component/card.dart';
import 'package:yosken_challenge1/model/fetch_my_location.dart' as my_location;

// final startFetchProvider = StateProvider((ref) => chargespots.chargerSpotsFutureProvider);


class ChargeSpotInfoPageView extends ConsumerWidget {
  const ChargeSpotInfoPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PageController pageController =
        PageController(viewportFraction: 0.85);
    print('beforeWatch');
    // final currentLatLng = ref.watch(chargespots.latLngProvider); //ボタン押したりinitstateで変わる

    final asyncMyLatLng = ref.watch(chargespots.rangeLatLngProvider);

    final asyncMyPosition = ref.watch(chargespots.myPositionProvider);

    //final fetch = ref.watch(startFetchProvider);//currentLatLngが変わることで、chargespotsFutureProviderが変わる（Api取得開始）

    final asyncValue = ref.watch(
        chargespots.chargerSpotsFutureProvider); //api取得したら変わる、取得するまでloading

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
            onPressed: () {
              ref.read(chargespots.countProvider.notifier).state ++;
              asyncMyPosition.when(data: (value){
                print('yes');
                ref.read(chargespots.rangeLatLngProvider.notifier).state = value;
              }, error: (error, stack) => print('Error: $error'), loading: ()=>print('loading'));
            },
            child: Container(
              height: 80,
              width: 80,
            )),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.fromLTRB(0, 0, 12, 12),
          child: SizedBox(
            height: 48,
            width: 120,
            child: ElevatedButton(
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
                    builder: (BuildContext context) => ChargeSpotInfoPage());
              },
              child: Text('リストを表示'),
            ),
          ),
        ),
        asyncValue.when(
          data: (value) {
            print('hello');
            return Container(
              height: 430,
              child: PageView(
                controller: pageController,
                children: makeCardList(value),
              ),
            );
          },
          error: (error, stack) => Text('Error: $error'),
          loading: () => Padding(
            padding: const EdgeInsets.symmetric(vertical: 175),
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
