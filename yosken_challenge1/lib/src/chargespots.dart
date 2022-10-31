import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:riverpod/riverpod.dart';

part 'chargespots.g.dart';

@JsonSerializable()
class LatLng {
  LatLng({
    required this.latitude,
    required this.longitude,
  });

  factory LatLng.fromJson(Map<String, dynamic> json) => _$LatLngFromJson(json);

  Map<String, dynamic> toJson() => _$LatLngToJson(this);

  final double? latitude;
  final double? longitude;
}

@JsonSerializable()
class ChargerSpotServiceTime {
  ChargerSpotServiceTime({
    required this.day, //定休日
    required this.start_time,
    required this.end_time,
  });

  factory ChargerSpotServiceTime.fromJson(Map<String, dynamic> json) =>
      _$ChargerSpotServiceTimeFromJson(json);

  Map<String, dynamic> toJson() => _$ChargerSpotServiceTimeToJson(this);

  final String?day;
  final String? start_time;
  final String? end_time;
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
    required this.charger_spot_service_times, //ChargerSpotServiceTimes->[day:定休日, start_time, end_time]
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
    'X-EVENE-NATIVE-API-TOKEN': 'C6DGdRH9XCD8jlEU'
  });
  if (response.statusCode == 200) {
    print(response.body);
    return ChargerSpots.fromJson(json.decode(response.body));
  } else {
    print('errorrrrr');
    throw Exception('Can\'t get users');
  }
}

final chargerSpotsFutureProvider = FutureProvider.family<ChargerSpots, SwAndNeLatLng>((ref, swAndNeLatLng) async {
  print('FutureProvider');
  final chargerSpots = await fetchChargerSpots(swAndNeLatLng);
  return chargerSpots;
});
