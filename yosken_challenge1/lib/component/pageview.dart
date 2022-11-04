import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yosken_challenge1/component/cardlist.dart';
import 'package:yosken_challenge1/src/chargespots.dart' as chargespots;
import 'package:riverpod/riverpod.dart';
import 'package:yosken_challenge1/component/pageview.dart';
import 'package:yosken_challenge1/component/card.dart';

final chargespots.SwAndNeLatLng swAndNeLatLng = chargespots.SwAndNeLatLng(
    34.683331703634124,
    139.7657155055581,
    35.686849507072736,
    139.77340835691592);

class ChargeSpotInfoPageView extends ConsumerWidget {
  const ChargeSpotInfoPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PageController pageController = PageController(viewportFraction: 0.85);
    print('beforeWatch');
    final asyncValue =
        ref.watch(chargespots.chargerSpotsFutureProvider(swAndNeLatLng));

    return Container(
      height: 430,
      // padding: const EdgeInsets.symmetric(horizontal: 32),
      child: asyncValue.when(
        data: (value) {
          print('hello');
          return PageView(
            controller: pageController,
            children: makeCardList(value),
          );
        },
        error: (error, stack) => Text('Error: $error'),
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }
}
