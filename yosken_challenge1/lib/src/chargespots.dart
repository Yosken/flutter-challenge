import 'package:json_annotation/json_annotation.dart';

part 'chargespots.g.dart';

@JsonSerializable()
class LatLngOfSpot {
  LatLngOfSpot({
    required this.latitude,
    required this.longitude,
  });

  factory LatLngOfSpot.fromJson(Map<String, dynamic> json) => _$LatLngFromJson(json);

  Map<String, dynamic> toJson() => _$LatLngToJson(this);

  final double? latitude;
  final double? longitude;
}

@JsonSerializable()
class SpotServiceTime {
  SpotServiceTime({
    required this.business_day,
    required this.day,
    required this.start_time,
    required this.end_time,
    required this.today,
  });

  factory SpotServiceTime.fromJson(Map<String, dynamic> json) =>
      _$ChargerSpotServiceTimeFromJson(json);

  Map<String, dynamic> toJson() => _$ChargerSpotServiceTimeToJson(this);

  final String? business_day;
  final String? day;
  final String? start_time;
  final String? end_time;
  final bool? today;
}

@JsonSerializable()
class SpotImage {
  SpotImage({
    required this.url,
  });

  factory SpotImage.fromJson(Map<String, dynamic> json) =>
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
  final List<SpotServiceTime>? charger_spot_service_times;
  final String? now_available;
  final List<SpotImage>? images;
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