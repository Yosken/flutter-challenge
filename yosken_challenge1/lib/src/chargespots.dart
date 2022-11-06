import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'as google;
import 'package:riverpod/riverpod.dart';
import 'package:yosken_challenge1/model/fetch_my_location.dart';
import 'package:yosken_challenge1/secret/key.dart' as key;

part 'chargespots.g.dart';

@JsonSerializable()
class LatLngOfChargerSpots {
  LatLngOfChargerSpots({
    required this.latitude,
    required this.longitude,
  });

  factory LatLngOfChargerSpots.fromJson(Map<String, dynamic> json) => _$LatLngFromJson(json);

  Map<String, dynamic> toJson() => _$LatLngToJson(this);

  final double? latitude;
  final double? longitude;
}

@JsonSerializable()
class ChargerSpotServiceTime {
  ChargerSpotServiceTime({
    required this.business_day,
    required this.day,
    required this.start_time,
    required this.end_time,
    required this.today,
  });

  factory ChargerSpotServiceTime.fromJson(Map<String, dynamic> json) =>
      _$ChargerSpotServiceTimeFromJson(json);

  Map<String, dynamic> toJson() => _$ChargerSpotServiceTimeToJson(this);

  final String? business_day;
  final String? day;
  final String? start_time;
  final String? end_time;
  final bool? today;
}

@JsonSerializable()
class ChargerSpotImage {
  ChargerSpotImage({
    required this.url,
  });

  factory ChargerSpotImage.fromJson(Map<String, dynamic> json) =>
      _$ChargerSpotImageFromJson(json);

  Map<String, dynamic> toJson() => _$ChargerSpotImageToJson(this);

  final String? url;
}

@JsonSerializable()
class ChargerDevice {
  ChargerDevice({
    required this.power, //充電出力
  });

  factory ChargerDevice.fromJson(Map<String, dynamic> json) =>
      _$ChargerDeviceFromJson(json);

  Map<String, dynamic> toJson() => _$ChargerDeviceToJson(this);

  final String? power;
}

@JsonSerializable()
class GogoChargerDevice {
  GogoChargerDevice({
    required this.number, //充電器数
  });

  factory GogoChargerDevice.fromJson(Map<String, dynamic> json) =>
      _$GogoChargerDeviceFromJson(json);

  Map<String, dynamic> toJson() => _$GogoChargerDeviceToJson(this);

  final String? number;
}

@JsonSerializable()
class ChargerSpot {
  ChargerSpot({
    required this.uuid,
    required this.charger_spot_service_times, //ChargerSpotServiceTimes->[定休日, start_time, end_time]
    required this.now_available,
    required this.images, //ChargerSpotImage->url
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.charger_devices, //ChargerDevice->power:充電出力
    required this.gogoev_charger_devices, //GogoChargerDevice->number:充電器数
  });

  factory ChargerSpot.fromJson(Map<String, dynamic> json) =>
      _$ChargerSpotFromJson(json);

  Map<String, dynamic> toJson() => _$ChargerSpotToJson(this);

  final String? uuid;
  final List<ChargerSpotServiceTime>? charger_spot_service_times;
  final String? now_available;
  final List<ChargerSpotImage>? images;
  final double? latitude;
  final double? longitude;
  final String? name;
  final List<ChargerDevice>? charger_devices;
  final List<GogoChargerDevice>? gogoev_charger_devices;
}

@JsonSerializable()
class ChargerSpots {
  ChargerSpots({
    required this.status,
    required this.charger_spots,
  });

  factory ChargerSpots.fromJson(Map<String, dynamic> json) =>
      _$ChargerSpotsFromJson(json);

  Map<String, dynamic> toJson() => _$ChargerSpotsToJson(this);

  final String? status;
  final List<ChargerSpot>? charger_spots;
}

class SwAndNeLatLng {
  SwAndNeLatLng(this.swLat, this.swLng, this.neLat, this.neLng);

  final swLat;
  final swLng;
  final neLat;
  final neLng;
}

List parseSpots(String responseBody) {
  var list = json.decode(responseBody)['charger_spots'] as List;
  List spots = list.map((model) => ChargerSpots.fromJson(model)).toList();
  return spots;
}

Future<ChargerSpots> fetchChargerSpots(SwAndNeLatLng swAndNeLatLng) async {
  final chargerSpots = <ChargerSpots>[];

  final fields = [
    'images',
    'charger_spot_service_times',
    'now_available',
    'charger_devices',
    'gogoev_charger_devices'
  ];
  final queryParameters = {
    'sw_lat': swAndNeLatLng.swLat.toString(),
    'sw_lng': swAndNeLatLng.swLng.toString(),
    'ne_lat': swAndNeLatLng.neLat.toString(),
    'ne_lng': swAndNeLatLng.neLng.toString(),
    'fields': fields.join(',')
  };
  final uri = Uri.https('stg.evene.jp', '/api/charger_spots', queryParameters);
  final response = await http.get(uri, headers: {
    'accept': 'application/json',
    'X-EVENE-NATIVE-API-TOKEN': key.token
  });
  if (response.statusCode == 200) {
    print(response.body);
    return ChargerSpots.fromJson(json.decode(response.body));
  } else {
    throw Exception('Can\'t get users');
  }
}

final rangeLatLngProvider = StateProvider((ref) {
  return SwAndNeLatLng(34.683331703634124, 139.7657155055581,
      35.686849507072736, 139.77340835691592);
});

final firstLatLngProvider = StateProvider((ref) => const google.LatLng(35.680399,139.767779));

// final myLatLngProvider = FutureProvider((ref) async{
//   final myLatLng = getMyL;
//   return myLatLng;
// });

final chargerSpotsFutureProvider = FutureProvider((ref) async {
  print('FutureProvider');
  final swAndNeLatLng = ref.watch(rangeLatLngProvider);
  return fetchChargerSpots(swAndNeLatLng);
});


// final myPositionProvider = FutureProvider((ref) async {
//   print('latlngfutureProvider');
//   final myPosition = await getMyPosition();
//   return myPosition;
// });

final myPositionProvider = FutureProvider((ref) async {
  print('latlngfutureProvider');
  final count = ref.watch(countProvider);
  final range = ref.watch(rangeProvider);
  final myPosition = getSwAndNeLatLng(range);
  return myPosition;
});

final countProvider = StateProvider((ref) => 0);

final rangeProvider = StateProvider((ref) => google.LatLng(0.1,0.1));


