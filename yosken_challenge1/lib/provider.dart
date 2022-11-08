import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yosken_challenge1/constant/importer_constant.dart';
import 'package:yosken_challenge1/constant/others.dart';
import 'package:yosken_challenge1/src/chargespots.dart';
import 'package:yosken_challenge1/model/fetch_my_location.dart';
import 'package:yosken_challenge1/model/get_api_data.dart';

final StateProvider rangeStateProvider = StateProvider((ref) => rangeLatLng);

final countProvider = StateProvider((ref) => 0);

final myPositionProvider = FutureProvider((ref) async {
  final count = ref.watch(countProvider);
  final range = ref.watch(rangeStateProvider);
  final myPosition = makeSwAndNeLatLng(range);
  return myPosition;
});

final chargerSpotsFutureProvider = FutureProvider((ref) async {
  final swAndNeLatLng = ref.watch(searchLatLngProvider);
  return fetchChargerSpots(swAndNeLatLng);
});

final firstLatLngProvider = StateProvider((ref) => firstLatLng);

final searchLatLngProvider = StateProvider((ref) {
  return SwAndNeLatLng(firstSwLat, firstSwLng,
      firstNeLat, firstNeLng);
});