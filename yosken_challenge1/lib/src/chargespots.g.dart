// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chargespots.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LatLngOfSpot _$LatLngFromJson(Map<String, dynamic> json) => LatLngOfSpot(
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$LatLngToJson(LatLngOfSpot instance) => <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

SpotServiceTime _$ChargerSpotServiceTimeFromJson(
        Map<String, dynamic> json) =>
    SpotServiceTime(
      business_day: json['business_day'] as String?,
      day: json['day'] as String?,
      start_time: json['start_time'] as String?,
      end_time: json['end_time'] as String?,
      today: json['today'] as bool?,
    );

Map<String, dynamic> _$ChargerSpotServiceTimeToJson(
        SpotServiceTime instance) =>
    <String, dynamic>{
      'business_day': instance.business_day,
      'day': instance.day,
      'start_time': instance.start_time,
      'end_time': instance.end_time,
      'today': instance.today,
    };

SpotImage _$ChargerSpotImageFromJson(Map<String, dynamic> json) =>
    SpotImage(
      url: json['url'] as String?,
    );

Map<String, dynamic> _$ChargerSpotImageToJson(SpotImage instance) =>
    <String, dynamic>{
      'url': instance.url,
    };

ChargerDevice _$ChargerDeviceFromJson(Map<String, dynamic> json) =>
    ChargerDevice(
      power: json['power'] as String?,
    );

Map<String, dynamic> _$ChargerDeviceToJson(ChargerDevice instance) =>
    <String, dynamic>{
      'power': instance.power,
    };

GogoChargerDevice _$GogoChargerDeviceFromJson(Map<String, dynamic> json) =>
    GogoChargerDevice(
      number: json['number'] as String?,
    );

Map<String, dynamic> _$GogoChargerDeviceToJson(GogoChargerDevice instance) =>
    <String, dynamic>{
      'number': instance.number,
    };

ChargerSpot _$ChargerSpotFromJson(Map<String, dynamic> json) => ChargerSpot(
      uuid: json['uuid'] as String?,
      charger_spot_service_times: (json['charger_spot_service_times']
              as List<dynamic>?)
          ?.map(
              (e) => SpotServiceTime.fromJson(e as Map<String, dynamic>))
          .toList(),
      now_available: json['now_available'] as String?,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => SpotImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      name: json['name'] as String?,
      charger_devices: (json['charger_devices'] as List<dynamic>?)
          ?.map((e) => ChargerDevice.fromJson(e as Map<String, dynamic>))
          .toList(),
      gogoev_charger_devices: (json['gogoev_charger_devices'] as List<dynamic>?)
          ?.map((e) => GogoChargerDevice.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChargerSpotToJson(ChargerSpot instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'charger_spot_service_times': instance.charger_spot_service_times,
      'now_available': instance.now_available,
      'images': instance.images,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'name': instance.name,
      'charger_devices': instance.charger_devices,
      'gogoev_charger_devices': instance.gogoev_charger_devices,
    };

ChargerSpots _$ChargerSpotsFromJson(Map<String, dynamic> json) => ChargerSpots(
      status: json['status'] as String?,
      charger_spots: (json['charger_spots'] as List<dynamic>?)
          ?.map((e) => ChargerSpot.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChargerSpotsToJson(ChargerSpots instance) =>
    <String, dynamic>{
      'status': instance.status,
      'charger_spots': instance.charger_spots,
    };
