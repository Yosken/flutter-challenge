import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/chargespots.dart' as chargespots;
import 'package:yosken_challenge1/component/card.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final chargespots.SwAndNeLatLng swAndNeLatLng = chargespots.SwAndNeLatLng(
    34.683331703634124,
    139.7657155055581,
    35.686849507072736,
    139.77340835691592);

class ChargeSpotInfoPage extends ConsumerWidget {
  const ChargeSpotInfoPage(this.controller,this.googleController,{Key? key}) : super(key: key);
  final PageController controller;
  final GoogleMapController googleController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = controller;
    final mapController = googleController;


    print('beforeWatch');
    final asyncValue =
    ref.watch(chargespots.chargerSpotsFutureProvider);

    return asyncValue.when(data: (value){
      print('hello');
      return SizedBox(
        height: double.infinity,
        child: DraggableScrollableSheet(
          initialChildSize: 0.92,
          minChildSize: 0,
          maxChildSize: 0.92,
          builder: (context, scrollController) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: ListView.builder(
              controller: scrollController,
              itemCount: value.charger_spots!.length,
              itemBuilder: (BuildContext context, int index) {
                final spotData = value.charger_spots![index];
                return makeCard(spotData, pageController, index, context, mapController);
              },
            ),
          ),
        ),
      );
    },
      error: (error, stack) => Text('Error: $error'),
      loading: () => Center(child: SizedBox(height: 80,width: 80,child: CircularProgressIndicator())));
  }
}