import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/chargespots.dart' as chargespots;
import 'package:riverpod/riverpod.dart';
import 'package:yosken_challenge1/component/card.dart';

final chargespots.SwAndNeLatLng swAndNeLatLng = chargespots.SwAndNeLatLng(
    34.683331703634124,
    139.7657155055581,
    35.686849507072736,
    139.77340835691592);

class ChargeSpotInfoPage extends ConsumerWidget {
  const ChargeSpotInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {


    print('beforeWatch');
    final asyncValue =
    ref.watch(chargespots.chargerSpotsFutureProvider(swAndNeLatLng));

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: asyncValue.when(data: (value){
          print('hello');
          return ListView.builder(
            itemCount: value.charger_spots!.length,
            itemBuilder: (BuildContext context, int index) {
              final spotData = value.charger_spots![index];
              return makeCard(spotData);
            },
          );
        },
          error: (error, stack) => Text('Error: $error'),
          loading: () => const CircularProgressIndicator(),),
      ),
    );
  }
}